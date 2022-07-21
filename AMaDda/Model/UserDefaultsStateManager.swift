//
//  FamilyContactManager.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/20.
//

import Foundation

final class UserDefaultsStateManager {
    private var userDefaultsDateFormatter: DateFormatter {
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyyMMdd"
         dateFormatter.timeZone = TimeZone(abbreviation: "KST")
         dateFormatter.locale = Locale(identifier: "ko_KR")
         return dateFormatter
     }
    func userEnteredApp() {
        let today = convertKoreaDate(Date())
        guard var finalEnteredDate = UserDefaults.standard.finalEnteredDate else {
            UserDefaults.standard.finalEnteredDate = today
            print("set finalEnteredDate")
            return
        }
        finalEnteredDate = convertKoreaDate(finalEnteredDate)
        let timeDiff = today.timeIntervalSince(finalEnteredDate)
        if timeDiff == 0 {
            print("It's already updated")
            print(finalEnteredDate)
            print(UserDefaults.standard.finalContactDiffDay)
            guard var testCount = UserDefaults.standard.testCount else { return }
            testCount += 1
            UserDefaults.standard.testCount = testCount
            print(testCount)
            return
        } else {
            updateFinalContactDiffDay()
            UserDefaults.standard.finalEnteredDate = today
        }
    }
    private func updateFinalContactDiffDay() {
        let dayAsSecond: Double = 86400
        guard var finalEnteredDate = UserDefaults.standard.finalEnteredDate else { return }
        guard var finalContactDiffDay = UserDefaults.standard.finalContactDiffDay else { return }
        finalEnteredDate = convertKoreaDate(finalEnteredDate)
        let today = convertKoreaDate(Date())
        let timeDiffInterval = today.timeIntervalSince(finalEnteredDate)
        let timeDiffDay = Int(timeDiffInterval / dayAsSecond)
        finalContactDiffDay += timeDiffDay
        UserDefaults.standard.finalContactDiffDay = finalContactDiffDay
    }
    private func convertKoreaDate(_ convertDate: Date) -> Date{
        let hourAsSecond: Int = 3600
        let koreaGreenwichDiff = TimeInterval(hourAsSecond*9)
        let convertedDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: convertDate)
        var convertedDate = Calendar.current.date(from: convertedDateComponent) ?? Date()
        convertedDate += koreaGreenwichDiff
        return convertedDate
    }
}
extension UserDefaults {
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
    var testCount: Int? {
             get {
                 var notificationCount: Int
                 if let count = UserDefaults.standard.value(forKey: "testCount") as? Int {
                     notificationCount = count
                     return notificationCount
                 }
                 return nil
             }
             set {
                 UserDefaults.standard.set(newValue, forKey: "testCount")
             }
         }
    var finalContactDiffDay: Int? {
        get {
            var finalContactCount: Int
            if let count = UserDefaults.standard.value(forKey: "finalContactDiffDay") as? Int {
                finalContactCount = count
                return finalContactCount
            }
            return nil
        }
        set {
            UserDefaults.standard.set(newValue, forKey: "finalContactDiffDay")
        }
    }
}
