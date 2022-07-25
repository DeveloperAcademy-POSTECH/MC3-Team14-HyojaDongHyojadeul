//
//  FamilyContactManager.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/20.
//

import Foundation

final class UserDefaultsStateManager {
    static func userEnteredApp() {
        let today = Date().convertedKoreaDate
        guard let finalEnteredDate = UserDefaults.standard.finalEnteredDate else {
            UserDefaults.standard.finalEnteredDate = today
            return
        }
        guard let offsetDay = Date.daysFromToday(finalEnteredDate), offsetDay != 0 else {
            return
        }
        updateFinalContactDiffDay(offsetDay)
        UserDefaults.standard.finalEnteredDate = today
    }
    static private func updateFinalContactDiffDay(_ offsetDay: Int) {
        guard var finalContactDiffDay = UserDefaults.standard.finalContactDiffDay else { return }
        finalContactDiffDay += offsetDay
        UserDefaults.standard.finalContactDiffDay = finalContactDiffDay
    }
}
