//
//  ReceiptResponse.swift
//  Application
//
//  Created by Steffen Ryll on 17.12.17.
//

struct ReceiptResponse: Codable {
    let statusCode: Int

    let appReceipt: AppReceipt?

    let latestInAppReceipts: [InAppReceipt]?

    enum CodingKeys: String, CodingKey {
        case statusCode = "status"
        case appReceipt = "receipt"
        case latestInAppReceipts = "latest_receipt_info"
    }
}
