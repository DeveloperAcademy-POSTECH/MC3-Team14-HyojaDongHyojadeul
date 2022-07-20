//
//  FamilyContactManager.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/20.
//

import Foundation

final class FamilyContactManager {
    private let today = Date()
    
    func updateFinalContact() {
        guard let finalConnectDate = UserDefaults.standard.finalConnectDate else {return}
        let offsetDateComponents = Calendar.current.dateComponents([.day], from: finalConnectDate, to: today)
        guard var finalContactCount = UserDefaults.standard.finalContactCount else {return}
        if let offsetDay = offsetDateComponents.day{
            finalContactCount += offsetDay
            UserDefaults.standard.finalContactCount = finalContactCount
        }
    }
    func setFinalContactDate() {
        
    }
}
extension UserDefaults {
    var finalConnectDate: Date? {
        get {
             var finalConnectDate: Date?
             if let date = UserDefaults.standard.value(forKey: "finalConnectDate") as? Date {
                 finalConnectDate = date
                 return finalConnectDate
             }
             return nil
         }
         set {
             UserDefaults.standard.set(newValue, forKey: "finalConnectDate")
         }
    }
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
