import Foundation
import LoggerAPI
import HeliumLogger

HeliumLogger.use(LoggerMessageType.info)

do {
    let server = try StudAppServer()
    server.run()
} catch let error {
    Log.error(error.localizedDescription)
}
