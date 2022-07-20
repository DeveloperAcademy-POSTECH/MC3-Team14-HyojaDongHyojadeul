//
//  UserNotificationManager.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/18.
//

import UserNotifications

final class UserNotificationManager {
    private let notificationCenter = UNUserNotificationCenter.current()
    private let notificationCycleDay = 36
    private var identifierDateFormatter: DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.locale = Locale(identifier: "ko_KR")
        return dateFormatter
    }
    func addRequest() {
        // TODO: notificationCount 앱 알림 횟수 설정할 떄 pending 삭제 후 UserDefaluts에 등록
        guard let userNotificationCycle = UserDefaults.standard.userNotificationCycle else {
            print("userNotificationCycle 값 없음")
            return
        }
        // TODO: 앱이 로드될 떄 finalContactCount 갱신 (finalContactDate와 오늘 날짜 차이를 계산하여 갱신 -> 연락하기 버튼을 누르면 0으로 갱신)
        guard var finalContactDiff = UserDefaults.standard.finalContactDiff else {
            print("finalContactDiff 값 없음")
            return
        }
        // MARK: - request 등록 날짜 계산. better way?
        requestPendingCount { [self] requestPendingCount in
            let requestRemainDateCount = userNotificationCycle * requestPendingCount
            finalContactDiff += requestRemainDateCount // 앱이 로드될 떄 갱신되면 필요없을듯
            let requestAddCount = (notificationCycleDay - requestRemainDateCount) / userNotificationCycle
            // MARK: - request 등록. better way?
            self.requestLastPendingDate { [self] requestLastPendingDate in
                var requestStartDate = Calendar.current.date(byAdding: .day, value: userNotificationCycle, to: requestLastPendingDate) ?? Date()
                for i in 0..<requestAddCount {
                    finalContactDiff += userNotificationCycle
                    var requestStartDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: requestStartDate)
                    requestStartDateComponents.hour = 14
                    requestStartDateComponents.minute = 0
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: requestStartDateComponents, repeats: false)
                    let notificationContent = createRequestContent(finalContactDiff)
                    let requestIdentifier = identifierDateFormatter.string(from: requestStartDate)
                    let request = UNNotificationRequest(identifier: requestIdentifier, content: notificationContent, trigger: notificationTrigger)
                    self.notificationCenter.add(request) { error in
                        if let Error = error {
                            print(Error)
                        }
                    }
                    requestStartDate = Calendar.current.date(byAdding: .day, value: userNotificationCycle, to: requestStartDate) ?? Date()
                    print("request\(i) 등록 완료")
                }
            }
        }
    }
    private func requestPendingCount(completion: @escaping(Int) -> Void) {
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            completion(notificationRequests.count)
        }
    }
    private func requestLastPendingDate(completion: @escaping(Date) -> Void) {
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            guard let notificationIdentifier = notificationRequests.last?.identifier else {
                completion(Date())
                return
            }
            // TODO: 왜인지 모르겠는데 날짜가 하루 적음
            completion(self.identifierDateFormatter.date(from: notificationIdentifier) ?? Date())
        }
    }
    private func createRequestContent(_ finalContactDiff: Int) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "가족에게 연락해보세요"
        var finalContactString = ""
        var finalContactAfterStirng = "넘었어요"
        switch finalContactDiff {
        case 0...7:
            finalContactString = "\(finalContactDiff)일"
            finalContactAfterStirng = "됐어요"
        case 8...14:
            finalContactString = "1주일"
        case 15...21:
            finalContactString = "2주일"
        case 22...28:
            finalContactString = "3주일"
        default:
            finalContactString = "한달"
        }
        notificationContent.body = "가족과 연락한지 \(finalContactString) \(finalContactAfterStirng)"
        notificationContent.sound = UNNotificationSound.default
        notificationContent.badge = 1
        return notificationContent
    }
    func removeAllPendingRequest() {
        notificationCenter.removeAllPendingNotificationRequests()
        print("Pending request 삭제 완료")
    }
    func updateRequestPendingContent() {
        guard var finalContactDiff = UserDefaults.standard.finalContactDiff else {return}
        guard let userNotificationCycle = UserDefaults.standard.userNotificationCycle else {return}
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            for request: UNNotificationRequest in notificationRequests {
                let currentRequest = request
                guard let currentRequestDate = self.identifierDateFormatter.date(from: currentRequest.identifier) else{return}
                let offsetDateComponents = Calendar.current.dateComponents([.day], from: Date(), to: currentRequestDate)
                guard let offsetDay = offsetDateComponents.day else {return}
                let requestFinalContactDiff = finalContactDiff + offsetDay
                let content = self.createRequestContent(requestFinalContactDiff)
                let updatedRequest = UNNotificationRequest(identifier: currentRequest.identifier, content: content, trigger: currentRequest.trigger)
                self.notificationCenter.add(updatedRequest)
                finalContactDiff += userNotificationCycle
            }
        }
    }
    // MARK: - testing function
#if DEBUG
    func checkPendingNotificationRequests() {
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            if notificationRequests.isEmpty {
                print("Pending request 없음")
            } else{
                for notification: UNNotificationRequest in notificationRequests {
                    print("----------requests info------------")
                    print(notification.identifier)
                    print(notification.content.title)
                    print(notification.content.body)
                    print(notification.trigger ?? "No trigger")
                    print("-----------------------------------")
                }
            }
        }
    }
#endif
}
