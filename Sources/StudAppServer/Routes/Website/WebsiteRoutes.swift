import Foundation
import Kitura
import OpenCloudKit

var copyrightMessage: String {
    let year = Calendar.current.component(.year, from: Date())
    return "© Copyright Steffen Ryll, \(year)"
}

func initializeWebsiteRoutes(in router: Router) {
    router.get("/") { _, response, _ in
        try response
            .render("studapp", context: ["copyrightMessage": copyrightMessage])
            .end()
    }

    router.get("/legal/?") { _, response, _ in
        try response
            .render("legal", context: ["copyrightMessage": copyrightMessage])
            .end()
    }

    router.get("/privacy/?") { _, response, _ in
        try response
            .render("privacy", context: ["copyrightMessage": copyrightMessage])
            .end()
    }

    router.get("/help/?") { _, response, _ in
        OrganizationRecord.fetch(desiredKeys: [.title, .iconThumbnail]) { result in
            let context: [String: Any] = [
                "copyrightMessage": copyrightMessage,
                "organizations": result.value ?? [],
            ]
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
            .render("robots", context: ["copyrightMessage": copyrightMessage])
            .end()
    }

    router.get("/apple-app-site-association") { _, response, _ in
        response.headers.setType("json")
        try response
            .render("apple-app-site-association", context: ["copyrightMessage": copyrightMessage])
            .end()
    }
}
