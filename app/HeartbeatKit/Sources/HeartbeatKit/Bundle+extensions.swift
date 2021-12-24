//
//  Bundle+extensions.swift
//  HeartbeatKit
//
//  Created by Aksel Dybdal on 07/11/2021.
//

import Foundation

extension Bundle {
    // Name of the app - title under the icon.
    var displayName: String? {
            return object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ??
                object(forInfoDictionaryKey: "CFBundleName") as? String
    }

    var appVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    }

    var buildVersion: String? {
        return Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    }
}
