func initializeStoeffnRoutes(in app: App) {
    app.router.get("/") { _, response, next in
        defer { next() }
        let context = ["name": "World"]
        try response
            .render("index", context: context)
            .end()
    }
}