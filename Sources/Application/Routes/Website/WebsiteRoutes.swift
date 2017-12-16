import Foundation
import OpenCloudKit

func initializeWebsiteRoutes(in app: App) {
    app.router.get("/privacy") { _, response, _ in
        try response
            .render("privacy", context: [:])
            .end()
    }

    app.router.get("/legal") { _, response, _ in
        try response
            .render("legal", context: [:])
            .end()
    }

    app.router.get("/help") { _, response, _ in
        var organizations = [OrganizationRecord]()

        let query = CKQuery(recordType: OrganizationRecord.recordType, predicate: NSPredicate(value: true))
        let desiredKeys: [OrganizationRecord.Keys] = [.title, .iconThumbnail]

        let operation = CKQueryOperation(query: query)
        operation.qualityOfService = .userInitiated
        operation.desiredKeys = desiredKeys.map { $0.rawValue }
        operation.queryCompletionBlock = { _, error in
            switch error {
            case nil:
                let context: [String: Any] = ["organizations": organizations]
                try? response
                    .render("help", context: context)
                    .end()
            default:
                try? response
                    .render("help", context: [:])
                    .end()
            }
        }
        operation.recordFetchedBlock = { record in
            guard let organization = OrganizationRecord(from: record) else { return }
            organizations.append(organization)
        }

        CKContainer.default().publicCloudDatabase.add(operation)
    }

    app.router.get("/") { _, response, _ in
        try response
            .render("index", context: [:])
            .end()
    }
}
