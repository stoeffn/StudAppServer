func initializeStoeffnRoutes(in app: App) {
    app.router.get("/") { _, response, _ in
        let context = ["name": "World"]
        try response
            .render("index", context: context)
            .end()
    }

    app.router.get("/legal") { _, response, _ in
        try response
            .render("legal", context: [:])
            .end()
    }
}
