//
//  AppStoreConfig.swift
//  StudAppServerPackageDescription
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

struct AppStoreConfig: Codable {
    let sharedSecret: String?

    init(sharedSecret: String? = nil) {
        self.sharedSecret = sharedSecret
    }

    static func fromFile(at url: URL) throws -> AppStoreConfig {
        let data = try Data(contentsOf: url)
        return try JSONDecoder().decode(AppStoreConfig.self, from: data)
    }
}
