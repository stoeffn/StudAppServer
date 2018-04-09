import Application
import Foundation
import HeliumLogger
import LoggerAPI

HeliumLogger.use(LoggerMessageType.info)

do {
    let server = try Application()
    server.run()
} catch let error {
    Log.error(error.localizedDescription)
}
