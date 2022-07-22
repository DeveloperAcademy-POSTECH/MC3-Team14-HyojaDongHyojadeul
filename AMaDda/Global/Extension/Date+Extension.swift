//
//  Date+Extension.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/22.
//

import Foundation

extension Date {
    static func convertKoreaDate(_ convertDate: Date) -> Date {
        let hourAsSecond: Int = 3600
        let koreaGreenwichDiff = TimeInterval(hourAsSecond * 9)
        let convertedDateComponent = Calendar.current.dateComponents([.year, .month, .day], from: convertDate)
        var convertedDate = Calendar.current.date(from: convertedDateComponent) ?? Date()
        convertedDate += koreaGreenwichDiff
        return convertedDate
    }
    static func offsetToday(_ compareDate: Date) -> Int {
        let today = Date.convertKoreaDate(Date())
        let convertedCompareDate = Date.convertKoreaDate(compareDate)
        let offsetDateComponents = Calendar.current.dateComponents([.day], from: today, to: convertedCompareDate)
        guard let offsetDay = offsetDateComponents.day, offsetDay != 0 else {
            return 0
        }
        if offsetDay > 0 {
            return offsetDay
        } else {
            return -offsetDay
        }
    }
}
