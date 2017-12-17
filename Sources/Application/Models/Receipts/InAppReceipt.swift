//
//  InAppReceipt.swift
//  Application
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

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
