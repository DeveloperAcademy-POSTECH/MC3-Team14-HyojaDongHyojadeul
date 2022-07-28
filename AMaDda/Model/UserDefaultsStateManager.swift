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
    let userNotificationManager = UserNotificationManager()
    static func userEnteredApp() {
        let today = Date().convertedKoreaDate
        guard let finalEnteredDate = UserDefaults.standard.finalEnteredDate else {
            UserDefaults.standard.finalEnteredDate = today
            return
        }
        // MARK: - Today already Entered App
        guard let offsetDay = Date.daysFromToday(finalEnteredDate), offsetDay != 0 else {
            return
        }
        // MARK: - First Entered App
        updateFinalContactDiffDay(offsetDay)
        updateTodayQuestion()
        updateContactGoalCount(offsetDay)
        UserDefaults.standard.finalEnteredDate = today
        UserDefaults.standard.isUserTodayContacted = false
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
    static private func updateContactGoalCount(_ offsetDay: Int) {
        var checkDate = Date().convertedKoreaDate
        var daysFromMonday = 0
        var weekDay = Calendar.current.dateComponents([.weekday], from: checkDate).weekday ?? 2
        while (weekDay != 2) {
            guard let pastDate = Calendar.current.date(byAdding: .day, value: -1, to: checkDate) else { return }
            checkDate = pastDate
            weekDay = Calendar.current.dateComponents([.weekday], from: checkDate).weekday ?? 2
            daysFromMonday += 1
        }
        if daysFromMonday < offsetDay {
            UserDefaults.standard.contactGoalCount = 0
        }
    }
    func userContacted() {
        let isUserTodayContacted = UserDefaults.standard.isUserTodayContacted
        if !isUserTodayContacted {
            UserDefaults.standard.finalContactDiffDay = 0
            UserDefaults.standard.contactGoalCount += 1
            userNotificationManager.updateRequestPendingContent()
            UserDefaults.standard.isUserTodayContacted = true
        }
    }
    func userChangeNotificationCycle(_ changedNotificationCycle: Int) {
        UserDefaults.standard.userNotificationCycle = changedNotificationCycle
        userNotificationManager.removeAllPendingRequest()
    }
}
