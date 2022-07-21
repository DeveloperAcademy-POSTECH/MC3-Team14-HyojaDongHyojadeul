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
        var data = [
            FamilyMemberData(name: "엄마", characterImageName: "Character1"),
            FamilyMemberData(name: "아빠", characterImageName: "Character2"),
            FamilyMemberData(name: "형", characterImageName: "Character3"),
            FamilyMemberData(name: "동생", characterImageName: "Character4"),
        ]
        return data
    }
}
#endif
