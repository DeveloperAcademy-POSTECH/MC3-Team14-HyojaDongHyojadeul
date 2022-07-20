//
//  NotificationDemoView.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/20.
//

import Foundation
import UIKit

final class NotificationDemoViewController: UIViewController {
    private let userNotificationManager = UserNotificationManager()
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .orange
        button.setTitle("UserDefaults 셋팅", for: .normal)
        return button
    }()
    private let button2: UIButton = {
        let button = UIButton()
        button.backgroundColor = .red
        button.setTitle("마지막 연락날짜 변경", for: .normal)
        return button
    }()
    private let button3: UIButton = {
        let button = UIButton()
        button.backgroundColor = .blue
        button.setTitle("request 출력", for: .normal)
        return button
    }()
    private let button4: UIButton = {
        let button = UIButton()
        button.backgroundColor = .gray
        button.setTitle("request 삭제", for: .normal)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }
    
    // MARK: - functions
    private func setUp() {
        view.backgroundColor = .systemBackground
        button.addTarget(self, action: #selector(setUpUserDefaults), for: .touchUpInside)
        button2.addTarget(self, action: #selector(changeFinalContactDiff), for: .touchUpInside)
        button3.addTarget(self, action: #selector(printPendingNotification), for: .touchUpInside)
        button4.addTarget(self, action: #selector(deleteAllRequests), for: .touchUpInside)
        
        view.addSubview(button)
        button.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(button2)
        button2.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(button3)
        button3.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 10),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        view.addSubview(button4)
        button4.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 10),
            button4.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    @objc func printPendingNotification() {
        userNotificationManager.checkPendingNotificationRequests()
    }
    @objc func deleteAllRequests() {
        userNotificationManager.removeAllPendingRequest()
    }
    @objc func changeFinalContactDiff() {
        UserDefaults.standard.finalContactDiff = 4
        userNotificationManager.updateRequestPendingContent()
    }
    @objc func setUpUserDefaults() {
        UserDefaults.standard.userNotificationCycle = 3
        UserDefaults.standard.finalContactDiff = 0
    }
}
