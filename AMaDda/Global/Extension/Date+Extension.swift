//
//  Date+Extension.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/22.
//

import UIKit

extension Date {
    var daysFromNow: Int {
        let calendar = Calendar.current
        let dateDiff = calendar.dateComponents([.day], from: self, to: Date.now)
        guard let term = dateDiff.day else { fatalError() }
        return term
    }
}
