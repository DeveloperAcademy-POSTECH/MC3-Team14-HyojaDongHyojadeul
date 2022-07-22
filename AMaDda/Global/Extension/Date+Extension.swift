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
}
