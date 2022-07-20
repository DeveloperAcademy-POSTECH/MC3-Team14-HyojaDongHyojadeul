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
        guard let finalConnectDate = UserDefaults.finalConnectDate else {return}
        let finalConnectDateComponents = Calendar.current.dateComponents([.day], from: finalConnectDate, to: today)
        print()
    }
}

extension UserDefaults {
    static var finalConnectDate: Date? {
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
}
