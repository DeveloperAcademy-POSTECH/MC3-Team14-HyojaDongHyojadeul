//
//  UserDefaults+Extension.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/19.
//

import Foundation

extension UserDefaults {
    var notificationCount: Int? {
        get {
            var notificationCount: Int
            if let count = UserDefaults.standard.value(forKey: "notificationCount") as? Int {
                notificationCount = count
                return notificationCount
            }
            return nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "notificationCount")
        }
    }
    var finalContactCount: Int? {
        get {
            var finalContactCount: Int
            if let count = UserDefaults.standard.value(forKey: "finalContactCount") as? Int {
                finalContactCount = count
                return finalContactCount
            }
            return nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "finalContactCount")
        }
    }
}
