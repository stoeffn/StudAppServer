import OpenCloudKit

func initializeStudAppRoutes(in app: App) {
    app.router.get("/studapp/privacy") { _, response, _ in
        try response
            .render("studapp/privacy", context: [:])
            .end()
    }

    app.router.get("/studapp/help") { _, response, _ in
        try response
            .render("studapp/help", context: [:])
            .end()
    }

    app.router.get("/studapp/?.*") { _, response, _ in
        try response
            .render("studapp/index", context: [:])
            .end()
    }
}
