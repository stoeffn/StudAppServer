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
        case title, iconThumbnail, icon
    }

    static let recordType: String = "Organization"

    let recordId: CKRecordID

    let title: String

    private let iconUrl: NSURL?

    private let iconThumbnailUrl: NSURL
}

extension OrganizationRecord {
    init?(from record: CKRecord) {
        guard record.recordType == OrganizationRecord.recordType,
            let title = record[Keys.title.rawValue] as? String,
            let iconThumbnailAsset = record[Keys.iconThumbnail.rawValue] as? CKAsset else { return nil }
        let iconAsset = record[Keys.icon.rawValue] as? CKAsset

        recordId = record.recordID
        self.title = title
        iconUrl = iconAsset?.fileURL
        iconThumbnailUrl = iconThumbnailAsset.fileURL
    }
}

extension OrganizationRecord {
    static func fetch(desiredKeys: [OrganizationRecord.Keys], completion: @escaping ResultHandler<[OrganizationRecord]>) {
        var organizations = [OrganizationRecord]()

        let query = CKQuery(recordType: OrganizationRecord.recordType, predicate: predicate)

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
