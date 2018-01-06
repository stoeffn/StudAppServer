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

    router.post("\(apiPath)/verify-receipt", middleware: BodyParser())
    router.post("\(apiPath)/verify-receipt") { request, response, _ in
        guard
            let body = request.body,
            case let .raw(receipt) = body,
            !receipt.isEmpty
        else {
            try response
                .send(json: ["state": "UNKNOWN"])
                .end()
            return
        }

        AppStoreService.shared.fetchVerified(receipt: receipt) { result in
            guard let receiptResponse = result.value else {
                try? response
                    .send(json: ["state": "UNKNOWN"])
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
            } else if let subscribedUntil = subscribedUntil {
                responseJson["state"] = "SUBSCRIBED"
                responseJson["subscribedUntil"] = subscribedUntil.timeIntervalSince1970
            } else {
                responseJson["state"] = "LOCKED"
            }

            try? response
                .send(json: responseJson)
                .end()
        }
    }
}
