//
//  UserDefaults+Extension.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/19.
//

import Foundation

extension UserDefaults {
    var userNotificationCycle: Int? {
        get {
            guard let count = UserDefaults.standard.value(forKey: "userNotificationCycle") as? Int else { return nil }
            return count
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "userNotificationCycle")
        }
    }
    var finalContactDiff: Int? {
        get {
            guard let count = UserDefaults.standard.value(forKey: "finalContactDiff") as? Int else { return nil }
            return count
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "finalContactDiff")
        }
    }
}
