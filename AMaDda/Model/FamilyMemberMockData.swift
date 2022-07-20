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
            FamilyMemberData(name: "엄마", characterImageName: "Character1", lastContact: "오늘 연락했어요"),
            FamilyMemberData(name: "아빠", characterImageName: "Character2", lastContact: "어제 연락했어요"),
            FamilyMemberData(name: "형", characterImageName: "Character3", lastContact: "어제 연락했어요"),
            FamilyMemberData(name: "동생", characterImageName: "Character4", lastContact: "어제 연락했어요"),
        ]
        return data
    }
}
#endif
