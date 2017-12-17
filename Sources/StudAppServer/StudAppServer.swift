import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraStencil
import OpenCloudKit

public let health = Health()

public final class StudAppServer {
    // MARK: - Kitura

    let router = Router()

    let cloudEnv = CloudEnv()

    // MARK: - Life Cycle

    public init() throws {
        router.setDefault(templateEngine: StencilTemplateEngine())
        router.all("/static", middleware: StaticFileServer(path: "./Views/static"))

        let config = try CKConfig(contentsOfFile: "\(ConfigurationManager.BasePath.pwd.path)/CloudKitConfiguration.json")
        CloudKit.shared.configure(with: config)

        initializeApiRoutes(in: router)
        initializeWebsiteRoutes(in: router)
    }

    public func run() {
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
