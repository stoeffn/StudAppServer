//
//  OrganizationRecord.swift
//  StudKit
//
//  Created by Steffen Ryll on 26.11.17.
//  Copyright © 2017 Steffen Ryll. All rights reserved.
//

import Foundation
import OpenCloudKit

public struct OrganizationRecord {
    enum Keys: String {
        case apiUrl, authenticationRealm, title, iconThumbnail, icon
    }

    public static let recordType: String = "Organization"

    let recordId: CKRecordID

    let apiUrl: URL

    let authenticationRealm: String

    public let title: String

    private let iconUrl: URL?

    private let iconThumbnailUrl: URL
}

extension OrganizationRecord {
    init?(from record: CKRecord) {
        guard record.recordType == OrganizationRecord.recordType,
            let apiUrlString = record[Keys.apiUrl.rawValue] as? String,
            let apiUrl = URL(string: apiUrlString),
            let authenticationRealm = record[Keys.authenticationRealm.rawValue] as? String,
            let title = record[Keys.title.rawValue] as? String,
            let iconThumbnailAsset = record[Keys.iconThumbnail.rawValue] as? CKAsset else { return nil }
        let iconAsset = record[Keys.icon.rawValue] as? CKAsset

        recordId = record.recordID
        self.apiUrl = apiUrl
        self.authenticationRealm = authenticationRealm
        self.title = title
        iconUrl = iconAsset?.fileURL as URL?
        iconThumbnailUrl = iconThumbnailAsset.fileURL as URL
    }
}
