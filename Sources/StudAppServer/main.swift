import Foundation
import LoggerAPI
import HeliumLogger

do {
    HeliumLogger.use(LoggerMessageType.info)

    let app = try App()
    app.run()
} catch let error {
    Log.error(error.localizedDescription)
}
