//
//  FamilyContactManager.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/20.
//

import Foundation

protocol TodayQuestionDelegate: AnyObject {
    func changeTodayQuestion(_ index: Int)
}

final class UserDefaultsStateManager {
    static var todayQuestionDelegate: TodayQuestionDelegate?
    static func userEnteredApp() {
        let today = Date().convertedKoreaDate
        guard let finalEnteredDate = UserDefaults.standard.finalEnteredDate else {
            UserDefaults.standard.finalEnteredDate = today
            return
        }
        guard let offsetDay = Date.daysFromToday(finalEnteredDate), offsetDay != 0 else {
            return
        }
        updateFinalContactDiffDay(offsetDay)
        updateTodayQuestion()
        UserDefaults.standard.finalEnteredDate = today
    }
    static private func updateFinalContactDiffDay(_ offsetDay: Int) {
        guard var finalContactDiffDay = UserDefaults.standard.finalContactDiffDay else { return }
        finalContactDiffDay += offsetDay
        UserDefaults.standard.finalContactDiffDay = finalContactDiffDay
    }
    static private func updateTodayQuestion() {
        var questionIndex = UserDefaults.standard.questionIndex
        if questionIndex >= TodayQuestionMockData.mockData.count - 1 {
            questionIndex = 0
        } else {
            questionIndex += 1
        }
        todayQuestionDelegate?.changeTodayQuestion(questionIndex)
        UserDefaults.standard.questionIndex = questionIndex
    }
}
