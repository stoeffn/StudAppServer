//
//  ReceiptRequest.swift
//  Application
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

struct ReceiptRequest: Codable {
    let receipt: Data

    let sharedSecret: String?

    let excludesOldTransactions: Bool

    enum CodingKeys: String, CodingKey {
        case receipt = "receipt-data"
        case sharedSecret = "password"
        case excludesOldTransactions = "exclude-old-transactions"
    }

    init(receipt: Data, sharedSecret: String? = nil, excludesOldTransactions: Bool = false) {
        self.receipt = receipt
        self.sharedSecret = sharedSecret
        self.excludesOldTransactions = excludesOldTransactions
    }
}
