import Foundation
import Kitura
import LoggerAPI
import Configuration
import CloudEnvironment
import KituraContracts
import Health
import KituraStencil
import OpenCloudKit

public let projectPath = ConfigurationManager.BasePath.project.path
public let health = Health()

public final class App {
    // MARK: - Kitura

    let router = Router()

    let cloudEnv = CloudEnv()

    // MARK: - CloudKit

    let cloudKitContainerIdentifier = "iCloud.SteffenRyll.StudKit"

    private(set) lazy var cloudKitAuthentication = CKServerToServerKeyAuth(
        keyID: "e4d873ce9d440d6b11007ea59c2cd4bd2c7dcfd7ce2def72890cbf19a398245a",
        privateKeyFile: "\(projectPath)/\(cloudKitContainerIdentifier).pem")

    private(set) lazy var cloudKitConfiguration = CKConfig(containers: [
        CKContainerConfig(containerIdentifier: cloudKitContainerIdentifier,
                          environment: .development,
                          serverToServerKeyAuth: cloudKitAuthentication)
    ])

    // MARK: - Life Cycle

    public init() throws {}

    func postInit() throws {
        router.setDefault(templateEngine: StencilTemplateEngine())
        router.all("/static", middleware: StaticFileServer(path: "./Views/static"))

        CloudKit.shared.configure(with: cloudKitConfiguration)

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
