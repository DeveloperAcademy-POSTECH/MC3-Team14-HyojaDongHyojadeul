//
//  FamilyMemberData.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/18.
//

import UIKit

struct FamilyMemberData {
    var name: String
    var characterImageName: String
    var lastContact: Date
    
    init(name: String) {
        self.name = name
        self.characterImageName = "Character1"
        self.lastContact = Date.now
    }
}
