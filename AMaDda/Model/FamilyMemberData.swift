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
    var lastContactDate: Date
    var initialized: Bool
    var contactNumber: String
    
    init(name: String, characterImageName: String, contactNumber: String) {
        self.name = name
        self.characterImageName = characterImageName
        self.lastContactDate = Date().convertedKoreaDate
        self.initialized = true
        self.contactNumber = contactNumber
    }
}

extension FamilyMemberData {
    mutating func updateLastContactDate() {
        initialized = false
        lastContactDate = Date().convertedKoreaDate
        updateUserDefaults()
    }
    
    func addFamilyMember() {
        var familyMembers = UserDefaults.standard.familyMembers
        familyMembers.append(self)
        UserDefaults.standard.familyMembers = familyMembers
    }
    
    func updateUserDefaults() {
        var familyMembers = UserDefaults.standard.familyMembers
        if let index = familyMembers.firstIndex(where: { $0.id == self.id }) {
            familyMembers.remove(at: index)
            familyMembers.insert(self, at: index)
        }
        UserDefaults.standard.familyMembers = familyMembers
    }
    
    var contactTermString: String {
        var finalContactString = ""
        var finalContactAfterStirng = " 넘었어요"
        if initialized {
            finalContactString = "통화를 하고\n"
            finalContactAfterStirng = "기록을 시작해볼까요?"
        } else {
            guard let term = Date.daysFromToday(lastContactDate) else { return "오류" }
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
        }
        return finalContactString + finalContactAfterStirng
    }
}
