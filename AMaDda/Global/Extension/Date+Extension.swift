//
//  Date+Extension.swift
//  AMaDda
//
//  Created by 이성민 & Lee Myeonhwan on 2022/07/22.
//
import Foundation

extension Date {
    var convertedKoreaDate: Date {
        let hourAsSecond: Int = 3600
        let koreaGreenwichDiff = TimeInterval(hourAsSecond * 9)
        let convertedDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: self)
        var convertedDate = Calendar.current.date(from: convertedDateComponent) ?? Date()
        convertedDate += koreaGreenwichDiff
        return convertedDate
    }
    static func daysFromToday(_ compareDate: Date) -> Int? {
        let today = Date().convertedKoreaDate
        let offsetDateComponents = Calendar.current.dateComponents([.day], from: today, to: compareDate.convertedKoreaDate)
        guard let offsetDay = offsetDateComponents.day else {
            return nil
        }
        if offsetDay > 0 {
            return offsetDay
        }
        else if offsetDay < 0 {
            return -offsetDay
        }
        else {
            return 0
        }
    }
}
