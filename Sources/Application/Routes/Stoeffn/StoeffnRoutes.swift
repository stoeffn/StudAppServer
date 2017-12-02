import LoggerAPI

func initializeStoeffnRoutes(in app: App) {
    app.router.get("/") { _, response, next in
        defer { next() }
        let context = ["name": "World"]
        do {
        try response
            .render("index", context: context)
            .end()
        } catch {
            print(error)
        }
    }
}
