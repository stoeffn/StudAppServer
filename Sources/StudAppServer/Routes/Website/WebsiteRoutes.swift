import Foundation
import Kitura
import OpenCloudKit

func initializeWebsiteRoutes(in router: Router) {
    router.get("/privacy") { _, response, _ in
        try response
            .render("privacy", context: [:])
            .end()
    }

    router.get("/legal") { _, response, _ in
        try response
            .render("legal", context: [:])
            .end()
    }

    router.get("/help") { _, response, _ in
        OrganizationRecord.fetch(desiredKeys: [.title, .iconThumbnail]) { result in
            let context: [String: Any] = ["organizations": result.value ?? []]
            try? response
                .render("help", context: context)
                .end()
        }
    }

    router.get("/") { _, response, _ in
        try response
            .render("index", context: [:])
            .end()
    }
}
