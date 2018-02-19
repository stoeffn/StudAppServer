import Foundation
import HeliumLogger
import LoggerAPI

HeliumLogger.use(LoggerMessageType.info)

do {
    let server = try StudAppServer()
    server.run()
} catch let error {
    Log.error(error.localizedDescription)
}
