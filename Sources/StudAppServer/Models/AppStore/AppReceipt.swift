//
//  AppReceipt.swift
//  Application
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

struct AppReceipt: Codable {
    let bundleId: String

    let appVersion: String

    let originalAppVersion: String

    let inAppReceipts: [InAppReceipt]

    let createdAt: Date

    enum CodingKeys: String, CodingKey {
        case bundleId = "bundle_id"
        case appVersion = "application_version"
        case originalAppVersion = "original_application_version"
        case inAppReceipts = "in_app"
        case createdAt = "receipt_creation_date"
    }
}
