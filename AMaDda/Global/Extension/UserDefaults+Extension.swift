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
    var finalContactDiffDay: Int? {
        get {
            guard let diff = UserDefaults.standard.value(forKey: "finalContactDiffDay") as? Int else { return nil }
            return diff
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "finalContactDiffDay")
        }
    }
    
    var familyMembers: [FamilyMemberData]? {
        get {
            var members: [FamilyMemberData]?
            if let data = UserDefaults.standard.value(forKey: "familyMembers") as? Data {
                members = try? PropertyListDecoder().decode([FamilyMemberData].self, from: data)
            }
            return members ?? []
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "familyMembers")
        }
    }
    var finalEnteredDate: Date? {
        get {
            guard let enteredDate = UserDefaults.standard.value(forKey: "finalEnteredDate") as? Date else {
                return nil
            }
            return enteredDate
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "finalEnteredDate")
            
        }
    }
}
