//
//  AppStoreService.swift
//  Application
//
//  Created by Steffen Ryll on 17.12.17.
//

import Foundation

final class AppStoreService {
    enum Environment {
        case sandbox
        case production
    }

    func verify(receipt _: Data, in _: Environment, handler _: @escaping ResultHandler<AppReceipt>) {
    }
}
