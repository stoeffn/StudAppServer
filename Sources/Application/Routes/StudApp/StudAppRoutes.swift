import Foundation
import OpenCloudKit

func initializeStudAppRoutes(in app: App) {
    app.router.get("/studapp/privacy") { _, response, _ in
        try response
            .render("studapp/privacy", context: [:])
            .end()
    }

    app.router.get("/studapp/help") { _, response, _ in
        let query = CKQuery(recordType: "Organization", predicate: NSPredicate(value: true))
        let database = CKContainer.default().publicCloudDatabase
        database.perform(query: query, inZoneWithID: nil) { (records, error) in
            let organizationNames = records?.flatMap { $0["title"] as? String } ?? []
            let context: [String: Any] = ["organizations": organizationNames]
            try? response
                .render("studapp/help", context: context)
                .end()
        }
    }

    app.router.get("/studapp/?.*") { _, response, _ in
        try response
            .render("studapp/index", context: [:])
            .end()
    }
}
