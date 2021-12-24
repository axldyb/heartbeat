//
//  UIDevice+extensions.swift
//  HeartbeatKit
//
//  Created by Aksel Dybdal on 07/11/2021.
//

import UIKit
import SystemConfiguration

public extension UIDevice {

    static let modelName: String = {
        var systemInfo = utsname()
        uname(&systemInfo)
        let machineMirror = Mirror(reflecting: systemInfo.machine)
        let identifier = machineMirror.children.reduce("") { identifier, element in
            guard let value = element.value as? Int8, value != 0 else { return identifier }
            return identifier + String(UnicodeScalar(UInt8(value)))
        }
        return identifier
    }()

    func deviceIdentifier() -> String {
        let key = "\(String(describing: Bundle.main.bundleIdentifier ?? "")).deviceIdentifier"

        if let deviceIdentifier = Keychain.load(key: key) {
            return String(data: deviceIdentifier, encoding: .utf8) ?? ""
        } else {
            let deviceIdentifier = Keychain.createUniqueID()

            guard let data = deviceIdentifier.data(using: .utf8) else {
                NSLog("Unable to store device identifier.")
                return deviceIdentifier
            }

            let status = Keychain.save(key: key, data: data)
            if status != errSecSuccess {
                NSLog("Unable to store device identifier: \(status)")
            }

            return deviceIdentifier
        }
    }
}
