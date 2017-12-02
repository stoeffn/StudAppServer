func initializeStudAppRoutes(in app: App) {
    app.router.get("/studapp") { _, response, next in
        defer { next() }
        let context = ["name": "World"]
        try! response
            .render("studapp/index", context: context)
            .end()
    }
}
