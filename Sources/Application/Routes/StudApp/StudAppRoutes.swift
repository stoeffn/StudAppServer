import Foundation
import OpenCloudKit

func initializeStudAppRoutes(in app: App) {
    app.router.get("/studapp/privacy") { _, response, _ in
        try response
            .render("studapp/privacy", context: [:])
            .end()
    }

    app.router.get("/studapp/help") { _, response, _ in
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
                    .render("studapp/help", context: context)
                    .end()
            default:
                try? response
                    .render("studapp/help", context: [:])
                    .end()
            }
        }
        operation.recordFetchedBlock = { record in
            guard let organization = OrganizationRecord(from: record) else { return }
            organizations.append(organization)
        }

        CKContainer.default().publicCloudDatabase.add(operation)
    }

    app.router.get("/studapp/?.*") { _, response, _ in
        try response
            .render("studapp/index", context: [:])
            .end()
    }
}
