//
//  FamilyContactManager.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/20.
//

import Foundation

final class UserDefaultsStateManager {
    private var today: Date {
        return convertKoreaDate(Date())
    }
    private var userDefaultsDateFormatter: DateFormatter {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyyMMdd"
         dateFormatter.timeZone = TimeZone(abbreviation: "KST")
         dateFormatter.locale = Locale(identifier: "ko_KR")
         return dateFormatter
     }
    func userEnteredApp() {
        guard var finalEnteredDate = UserDefaults.standard.finalEnteredDate else {
            UserDefaults.standard.finalEnteredDate = today
            return
        }
        finalEnteredDate = convertKoreaDate(finalEnteredDate)
        let offsetDateComponents = Calendar.current.dateComponents([.day], from: finalEnteredDate, to: today)
        guard let offsetDay = offsetDateComponents.day else { return }
        if offsetDay == 0 {
            return
        } else {
            updateFinalContactDiffDay()
            UserDefaults.standard.finalEnteredDate = today
        }
    }
    private func updateFinalContactDiffDay() {
        guard var finalEnteredDate = UserDefaults.standard.finalEnteredDate else { return }
        guard var finalContactDiffDay = UserDefaults.standard.finalContactDiffDay else { return }
        finalEnteredDate = convertKoreaDate(finalEnteredDate)
        let offsetDateComponents = Calendar.current.dateComponents([.day], from: finalEnteredDate, to: today)
        guard let offsetDay = offsetDateComponents.day else { return }
        finalContactDiffDay += offsetDay
        UserDefaults.standard.finalContactDiffDay = finalContactDiffDay
    }
    private func convertKoreaDate(_ convertDate: Date) -> Date {
        let hourAsSecond: Int = 3600
        let koreaGreenwichDiff = TimeInterval(hourAsSecond*9)
        let convertedDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: convertDate)
        var convertedDate = Calendar.current.date(from: convertedDateComponent) ?? Date()
        convertedDate += koreaGreenwichDiff
        return convertedDate
    }
}
