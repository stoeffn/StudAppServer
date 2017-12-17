//
//  ReceiptRequest.swift
//  StudAppServerPackageDescription
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

struct ReceiptRequest: Codable {
    let receiptData: Data

    let sharedSecret: String?

    let excludesOldTransactions: Bool

    enum CodingKeys: String, CodingKey {
        case receiptData = "receipt-data"
        case sharedSecret = "password"
        case excludesOldTransactions = "exclude-old-transactions"
    }
}
