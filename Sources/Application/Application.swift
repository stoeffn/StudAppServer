import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraStencil

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public final class App {
    let router = Router()
    let cloudEnv = CloudEnv()

    public init() throws {}

    func postInit() throws {
        router.setDefault(templateEngine: StencilTemplateEngine())
        router.all("/static", middleware: StaticFileServer(path: "./Views/static"))

        initializeMetrics(in: self)
        initializeHealthRoutes(in: self)
        initializeStoeffnRoutes(in: self)
        initializeStudAppRoutes(in: self)
    }

    public func run() throws {
        try postInit()
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
