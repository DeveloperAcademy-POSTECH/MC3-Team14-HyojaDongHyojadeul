//
//  UserDefaults+Extension.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/19.
//

import Foundation

extension UserDefaults {
    // MARK: - User connect data
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
    var checkedOnboarding: Bool? {
        get {
            let count = UserDefaults.standard.bool(forKey: TextLiteral.checkedOnboarding)
            return count
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.checkedOnboarding)
        }
    }
    // MARK: - notification data
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
    // MARK: - question data
    var questionIndex: Int {
        get {
            guard let index = UserDefaults.standard.value(forKey: TextLiteral.questionIndex) as? Int else { return 0 }
            return index
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.questionIndex)
        }
    }
    // MARK: - family data
    var familyMembers: [FamilyMemberData] {
        get {
            var members: [FamilyMemberData] = []
            if let data = UserDefaults.standard.value(forKey: "familyMembers") as? Data {
                do {
                    members = try PropertyListDecoder().decode([FamilyMemberData].self, from: data)
                } catch {
                    print("Unable to decode UserDefaults")
                }
            }
            return members
        }
        set {
            UserDefaults.standard.set(try? PropertyListEncoder().encode(newValue), forKey: "familyMembers")
        }
    }
    // MARK: - Feedback data
    var userContactGoal: Int {
        get {
            guard let goal = UserDefaults.standard.value(forKey: TextLiteral.userContactGoal) as? Int else { return 2 }
            return goal
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.userContactGoal)
        }
    }
    var contactGoalCount: Int {
        get {
            guard let count = UserDefaults.standard.value(forKey: TextLiteral.contactGoalCount) as? Int else { return 1 }
            return count
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.contactGoalCount)
        }
    }
    var isUserTodayContacted: Bool {
        get {
            let check = UserDefaults.standard.bool(forKey: TextLiteral.isUserTodayContacted)
            return check
        }
        set {
            UserDefaults.standard.set(newValue, forKey: TextLiteral.isUserTodayContacted)
        }
    }
}
