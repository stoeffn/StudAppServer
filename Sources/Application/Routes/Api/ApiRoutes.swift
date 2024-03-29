//
//  ApiRoutes.swift
//  StudAppServer
//
//  Created by Steffen Ryll on 16.12.17.
//

import Foundation
import Kitura

private let apiPath = "/api/v1"

func initializeApiRoutes(in router: Router) {
    router.get("\(apiPath)/health/?") { _, response, _ in
        let result = health.status.toSimpleDictionary()
        try response
            .status(health.status.state == .UP ? .OK : .serviceUnavailable)
            .send(json: result)
            .end()
    }
}
