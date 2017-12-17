//
//  ReceiptService.swift
//  Application
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

final class ReceiptService {
    enum Environment {
        case sandbox
        case production
    }

    func verify(receipt _: Data, in _: Environment, handler _: @escaping ResultHandler<AppReceipt>) {
    }
}
