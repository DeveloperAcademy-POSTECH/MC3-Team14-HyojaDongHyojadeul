//
//  FamilyMemberMockData.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/18.
//

import UIKit

#if DEBUG
final class FamilyMemberMockData {
    static var familyMemberData: [FamilyMemberData] = {
        let calendar = Calendar.current
        
        var dateComponents = DateComponents()
        dateComponents.year = 2022
        dateComponents.month = 7
        dateComponents.day = 21
        
        var dateComponents1 = DateComponents()
        dateComponents1.year = 2022
        dateComponents1.month = 7
        dateComponents1.day = 16
        
        guard let someDateTime = calendar.date(from: dateComponents) else { fatalError() }
        guard let someDateTime1 = calendar.date(from: dateComponents1) else { fatalError() }
        var data = [
            FamilyMemberData(name: "엄마", characterImageName: "Character2", lastContactDate: someDateTime),
            FamilyMemberData(name: "아빠", characterImageName: "Character2", lastContactDate: someDateTime1),
        ]
        return data
    }()
}
#endif
