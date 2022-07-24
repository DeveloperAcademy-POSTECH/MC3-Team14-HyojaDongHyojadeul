//
//  FamilyMemberData.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/18.
//

import UIKit

struct FamilyMemberData: Codable {
    var id = UUID()
    var name: String
    var characterImageName: String
    var lastContact: Date
    
    init(name: String, characterImageName: String, lastContact: Date) {
        self.name = name
        self.characterImageName = characterImageName
        self.lastContact = lastContact
    }
}

extension FamilyMemberData {
    mutating func updateLastContact() {
        lastContact = Date.now
        updateUserDefaults()
    }
    
    func updateUserDefaults() {
        guard var familyArray = UserDefaults.standard.familyMembers else { return }
        guard let index = familyArray.firstIndex(where: { $0.id == self.id }) else { return }
        familyArray.remove(at: index)
        familyArray.append(self)
    }
    
    var contactTermString: String {
        let term = lastContact.daysFromNow
        var finalContactString = ""
        var finalContactAfterStirng = " 넘었어요"
        switch term {
        case 0:
            finalContactAfterStirng = "오늘 연락했어요"
        case 1...6:
            finalContactString = "\(term)일"
            finalContactAfterStirng = " 됐어요"
        case 7:
            finalContactString = "1주일"
            finalContactAfterStirng = " 됐어요"
        case 8...14:
            finalContactString = "1주일"
        case 15...21:
            finalContactString = "2주일"
        case 22...28:
            finalContactString = "3주일"
        default:
            finalContactString = "한달"
        }
        return finalContactString + finalContactAfterStirng
    }
}
