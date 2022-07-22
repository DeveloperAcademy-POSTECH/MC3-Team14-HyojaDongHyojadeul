//
//  FamilyContactManager.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/20.
//

import Foundation

final class UserDefaultsStateManager {
    static func userEnteredApp() {
        let today = Date.convertKoreaDate(Date())
        guard var finalEnteredDate = UserDefaults.standard.finalEnteredDate else {
            UserDefaults.standard.finalEnteredDate = today
            return
        }
        finalEnteredDate = Date.convertKoreaDate(finalEnteredDate)
        let offsetDateComponents = Calendar.current.dateComponents([.day], from: finalEnteredDate, to: today)
        guard let offsetDay = offsetDateComponents.day, offsetDay != 0 else { return }
        updateFinalContactDiffDay(finalEnteredDate)
        UserDefaults.standard.finalEnteredDate = today
    }
    static private func updateFinalContactDiffDay(_ finalEnteredDate: Date) {
        let today = Date.convertKoreaDate(Date())
        guard var finalContactDiffDay = UserDefaults.standard.finalContactDiffDay else { return }
        let offsetDateComponents = Calendar.current.dateComponents([.day], from: finalEnteredDate, to: today)
        guard let offsetDay = offsetDateComponents.day else { return }
        finalContactDiffDay += offsetDay
        UserDefaults.standard.finalContactDiffDay = finalContactDiffDay
    }
}
