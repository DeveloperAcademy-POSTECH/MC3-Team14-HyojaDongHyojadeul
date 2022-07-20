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
            guard let count = UserDefaults.standard.value(forKey: "notificationCount") as? Int else {
                return nil
            }
            notificationCount = count
            return notificationCount
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "notificationCount")
        }
    }
    var finalContactCount: Int? {
        get {
            var finalContactCount: Int
            guard let count = UserDefaults.standard.value(forKey: "finalContactCount") as? Int else {
                return nil
            }
            finalContactCount = count
            return finalContactCount
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "finalContactCount")
        }
    }
}
