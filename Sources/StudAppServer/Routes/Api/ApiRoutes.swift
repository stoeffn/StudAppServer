//
//  ApiRoutes.swift
//  StudAppServer
//
//  Created by Steffen Ryll on 16.12.17.
//

import Foundation
import Kitura

private let apiPath = "/api/v1"
private let subscriptionProductIdentifier = "SteffenRyll.StudApp.Subscription"
private let unlockProductIdentifier = "SteffenRyll.StudApp.Unlock"

func initializeApiRoutes(in router: Router) {
    router.get("\(apiPath)/health") { _, response, _ in
        let result = health.status.toSimpleDictionary()
        try response
            .status(health.status.state == .UP ? .OK : .serviceUnavailable)
            .send(json: result)
            .end()
    }

    router.post("\(apiPath)/verify-receipt") { request, response, _ in
        var data = Data()
        _ = try request.read(into: &data)

        AppStoreService.shared.fetchVerified(receipt: data) { result in
            guard let receiptResponse = result.value else {
                try? response
                    .send(json: [
                        "error": result.error?.localizedDescription,
                    ])
                    .end()
                return
            }

            let subscribedUntil = receiptResponse.appReceipt?.inAppReceipts
                .filter { $0.productId == subscriptionProductIdentifier && $0.cancelledAt == nil }
                .flatMap { $0.subscriptionExpiresAt }
                .filter { $0 > Date() }
                .max()

            let isUnlocked = receiptResponse.appReceipt?.inAppReceipts
                .filter { $0.productId == unlockProductIdentifier && $0.cancelledAt == nil }
                .first != nil

            var responseJson = [String: Any]()

            if isUnlocked {
                responseJson["state"] = "UNLOCKED"
            } else if subscribedUntil != nil {
                responseJson["state"] = "SUBSCRIBED"
                responseJson["subscribedUntil"] = subscribedUntil?.timeIntervalSince1970
            } else {
                responseJson["state"] = "LOCKED"
            }

            print(responseJson)

            try? response
                .send(json: responseJson)
                .end()
        }
    }
}
