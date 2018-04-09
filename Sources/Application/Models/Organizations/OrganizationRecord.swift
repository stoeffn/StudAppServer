//
//  OrganizationRecord.swift
//  Application
//
//  Created by Steffen Ryll on 26.11.17.
//  Copyright © 2017 Steffen Ryll. All rights reserved.
//

import Foundation
import OpenCloudKit

struct OrganizationRecord {
    enum Keys: String {
        case title, isEnabled, iconThumbnail, icon
    }

    static let recordType: String = "Organization"

    let recordId: CKRecordID

    let title: String

    let isEnabled: Bool

    private let iconThumbnailUrl: NSURL
}

extension OrganizationRecord {
    init?(from record: CKRecord) {
        guard record.recordType == OrganizationRecord.recordType,
            let title = record[Keys.title.rawValue] as? String,
            let isEnabled = record[Keys.isEnabled.rawValue] as? Bool,
            let iconThumbnailAsset = record[Keys.iconThumbnail.rawValue] as? CKAsset else { return nil }

        recordId = record.recordID
        self.title = title
        self.isEnabled = isEnabled
        iconThumbnailUrl = iconThumbnailAsset.fileURL
    }
}

extension OrganizationRecord {
    static func fetch(desiredKeys: [OrganizationRecord.Keys], completion: @escaping ResultHandler<[OrganizationRecord]>) {
        var organizations = [OrganizationRecord]()

        let query = CKQuery(recordType: OrganizationRecord.recordType, predicate: NSPredicate(value: true))

        let operation = CKQueryOperation(query: query)
        operation.qualityOfService = .userInitiated
        operation.desiredKeys = desiredKeys.map { $0.rawValue }
        operation.queryCompletionBlock = { _, error in
            completion(Result(organizations, error: error))
        }
        operation.recordFetchedBlock = { record in
            guard let organization = OrganizationRecord(from: record) else { return }
            organizations.append(organization)
        }

        CKContainer.default().publicCloudDatabase.add(operation)
    }
}
