func initializeStudAppRoutes(in app: App) {
    app.router.get("/studapp/privacy") { _, response, next in
        defer { next() }
        try response
            .render("studapp/privacy", context: [:])
            .end()
    }

    app.router.get("/studapp/?.*") { _, response, next in
        defer { next() }
        try response
            .render("studapp/index", context: [:])
            .end()
    }
}
