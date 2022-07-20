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
            print("notificationCount 값 없음")
            return
        }
        // TODO: 앱이 로드될 떄 finalContactCount 갱신 (finalContactDate와 오늘 날짜 차이를 계산하여 갱신 -> 연락하기 버튼을 누르면 0으로 갱신)
        guard var finalContactCount = UserDefaults.standard.finalContactCount else {
            print("finalContactCount 값 없음")
            return
        }
        // MARK: - request 등록 날짜 계산. better way?
        getRequestPendingCount { [self] requestPendingCount in
            let requestRemainDateCount = userNotificationCycle * requestPendingCount
            finalContactCount += requestRemainDateCount // 앱이 로드될 떄 갱신되면 필요없을듯
            let requestAddCount = (notificationCycleDay - requestRemainDateCount) / userNotificationCycle
            // MARK: - request 등록. better way?
            self.getRequestLastPendingDate { [self] requestLastPendingDate in
                var requestStartDate = Calendar.current.date(byAdding: .day, value: userNotificationCycle + 1, to: requestLastPendingDate) ?? Date()
                for i in 0..<requestAddCount {
                    finalContactCount += userNotificationCycle
                    var requestStartDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: requestStartDate)
                    requestStartDateComponents.hour = 14
                    requestStartDateComponents.minute = 0
                    let notificationTrigger = UNCalendarNotificationTrigger(dateMatching: requestStartDateComponents, repeats: false)
                    let notificationContent = createRequestContent(finalContactCount)
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
    private func getRequestPendingCount(completion: @escaping(Int) -> Void) {
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            completion(notificationRequests.count)
        }
    }
    private func getRequestLastPendingDate(completion: @escaping(Date) -> Void) {
        notificationCenter.getPendingNotificationRequests { (notificationRequests) in
            guard let notificationIdentifier = notificationRequests.last?.identifier else {
                completion(Date())
                return
            }
            // TODO: 왜인지 모르겠는데 날짜가 하루 적음
            completion(self.identifierDateFormatter.date(from: notificationIdentifier) ?? Date())
        }
    }
    private func createRequestContent(_ finalContact: Int) -> UNMutableNotificationContent {
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "가족에게 연락해보세요"
        var finalContactString = ""
        var finalContactAfterStirng = ""
        switch finalContact {
        case 0...7:
            finalContactString = "\(finalContact)일"
            finalContactAfterStirng = "됐어요"
        case 8...14:
            finalContactString = "1주일"
            finalContactAfterStirng = "넘었어요"
        case 15...21:
            finalContactString = "2주일"
            finalContactAfterStirng = "넘었어요"
        case 22...28:
            finalContactString = "3주일"
            finalContactAfterStirng = "넘었어요"
        default:
            finalContactString = "한달"
            finalContactAfterStirng = "넘었어요"
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
