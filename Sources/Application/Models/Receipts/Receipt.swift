//
//  Receipt.swift
//  StudAppServer
//
//  Created by Steffen Ryll on 16.12.17.
//

import Foundation

struct ReceiptResponse: Codable {
    let statusCode: Int

    let appReceipt: AppReceipt

    let latestInAppReceipts: [InAppReceipt]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case appReceipt = "receipt"
        case latestInAppReceipts = "latest_receipt_info"
    }
}

struct AppReceipt: Codable {
    let bundleId: String

    let appVersion: String

    let originalAppVersion: String

    let inAppReceipts: [InAppReceipt]

    let createdAt: Date

    let expiresAt: Date

    enum CodingKeys: String, CodingKey {
        case bundleId = "bundle_id"
        case appVersion = "application_version"
        case originalAppVersion = "original_application_version"
        case inAppReceipts = "in_app"
        case createdAt = "creation_date"
        case expiresAt = "expiration_date"
    }
}

struct InAppReceipt: Codable {
    let productId: String

    let transactionId: String

    let originalTransactionId: String

    let purchasedAt: Date

    let originallyPurchasedAt: Date

    let cancelledAt: Date?

    let subscriptionExpiresAt: Date?

    enum CodingKeys: String, CodingKey {
        case productId = "product_id"
        case transactionId = "transaction_id"
        case originalTransactionId = "original_transaction_id"
        case purchasedAt = "purchase_date"
        case originallyPurchasedAt = "original_purchase_date"
        case cancelledAt = "cancellation_date"
        case subscriptionExpiresAt = "expires_date"
    }
}
