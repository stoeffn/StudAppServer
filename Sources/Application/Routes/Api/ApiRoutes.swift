//
//  ApiRoutes.swift
//  StudAppServer
//
//  Created by Steffen Ryll on 16.12.17.
//

private let apiPath = "/api/v1"

func initializeApiRoutes(in app: App) {
    app.router.get("\(apiPath)/verify-receipt") { _, response, _ in
        try response
            .send(json: [:])
            .end()
    }
}
