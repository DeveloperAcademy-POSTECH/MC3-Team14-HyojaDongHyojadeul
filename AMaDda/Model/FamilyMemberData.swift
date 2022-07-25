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
    
    init(name: String, characterImageName: String, lastContactDate: Date) {
        self.name = name
        self.characterImageName = characterImageName
        self.lastContactDate = lastContactDate
        self.initialized = true
        // TODO: 인스턴스가 생성될 때는 Date.now로 initialize 하기
        // 현재는 mockData 사용하기 위해 lastContact로 init 선언
    }
}

extension FamilyMemberData {
    mutating func updateLastContact() {
        initialized = false
        lastContactDate = Date.now
        updateUserDefaults()
    }
    
    private func updateUserDefaults() {
        guard var familyMembers = UserDefaults.standard.familyMembers else { return }
        if let index = familyMembers.firstIndex(where: { $0.id == self.id }) {
            familyMembers.remove(at: index)
            familyMembers.insert(self, at: index)
        } else {
            familyMembers.append(self)
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
