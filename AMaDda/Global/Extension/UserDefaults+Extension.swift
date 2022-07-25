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
            guard let count = UserDefaults.standard.value(forKey: TextLiteral.userNotificationCycle) as? Int else { return nil }
            return count
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.userNotificationCycle)
        }
    }
    var finalContactDiffDay: Int? {
        get {
            guard let diff = UserDefaults.standard.value(forKey: TextLiteral.finalContactDiffDay) as? Int else { return nil }
            return diff
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.finalContactDiffDay)
        }
    }
    var finalEnteredDate: Date? {
        get {
            guard let enteredDate = UserDefaults.standard.value(forKey: TextLiteral.finalEnteredDate) as? Date else {
                return nil
            }
            return enteredDate
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.finalEnteredDate)
        }
    }
    var questionIndex: Int {
        get {
            guard let index = UserDefaults.standard.value(forKey: TextLiteral.questionIndex) as? Int else { return 0 }
            return index
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.questionIndex)
        }
    }
}
