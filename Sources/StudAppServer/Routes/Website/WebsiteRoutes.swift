import Foundation
import Kitura
import OpenCloudKit

func initializeWebsiteRoutes(in router: Router) {
    router.get("/") { _, response, _ in
        try response
            .render("studapp", context: [:])
            .end()
    }

    router.get("/legal/?") { _, response, _ in
        try response
            .render("legal", context: [:])
            .end()
    }

    router.get("/privacy/?") { _, response, _ in
        try response
            .render("privacy", context: [:])
            .end()
    }

    router.get("/help/?") { _, response, _ in
        OrganizationRecord.fetch(desiredKeys: [.title, .iconThumbnail]) { result in
            let context: [String: Any] = ["organizations": result.value ?? []]
            try? response
                .render("help", context: context)
                .end()
        }
    }

    router.get("/sign-in/?") { request, response, _ in
        let query = request.parsedURL.query.map { "?\($0)" } ?? ""
        try response.redirect("studapp://sign-in\(query)")
    }

    router.get("/robots.txt") { _, response, _ in
        try response
            .render("robots", context: [:])
            .end()
    }

    router.get("/apple-app-site-association") { _, response, _ in
        response.headers.setType("json")
        try response
            .render("apple-app-site-association", context: [:])
            .end()
    }
}
