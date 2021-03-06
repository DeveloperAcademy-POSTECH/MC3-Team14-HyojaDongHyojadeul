//
//  FamilyMemberMockData.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/18.
//

import UIKit

#if DEBUG
final class FamilyMemberMockData {
    static var familyMemberData: [FamilyMemberData] {
        let data = [
            FamilyMemberData(name: "엄마", characterImage: UIImage(named: "Character1")!, description: "오늘 연락했어요"),
            FamilyMemberData(name: "아빠", characterImage: UIImage(named: "Character2")!, description: "어제 연락했어요"),
            FamilyMemberData(name: "형", characterImage: UIImage(named: "Character3")!, description: "어제 연락했어요"),
            FamilyMemberData(name: "동생", characterImage: UIImage(named: "Character4")!, description: "어제 연락했어요"),
        ]
        return data
    }
}
#endif
