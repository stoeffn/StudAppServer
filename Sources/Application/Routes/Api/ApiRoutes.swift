//
//  ApiRoutes.swift
//  StudAppServer
//
//  Created by Steffen Ryll on 16.12.17.
//

import Foundation

private let apiPath = "/api/v1"

func initializeApiRoutes(in app: App) {
    app.router.post("\(apiPath)/verify-receipt") { request, response, _ in
        var data = Data()
        let length = try request.read(into: &data)
        try response
            .send(json: [
                "length": length
            ])
            .end()
    }
}
