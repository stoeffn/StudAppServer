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

        let projectPath = ConfigurationManager.BasePath.pwd.path

        let cloudKitConfig = try CKConfig(contentsOfFile: "\(projectPath)/CloudKitConfiguration.json")
        CloudKit.shared.configure(with: cloudKitConfig)

        let appStoreConfig = try AppStoreConfig.fromFile(at: URL(fileURLWithPath: "\(projectPath)/AppStoreConfiguration.json"))
        AppStoreService.shared.configuration = appStoreConfig

        initializeApiRoutes(in: router)
        initializeWebsiteRoutes(in: router)
    }

    public func run() {
        Kitura.addHTTPServer(onPort: cloudEnv.port, with: router)
        Kitura.run()
    }
}
