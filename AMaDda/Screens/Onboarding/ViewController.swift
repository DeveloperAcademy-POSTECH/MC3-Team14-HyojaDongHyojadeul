//
//  ViewController.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/14.
//

import UIKit

let padding = 20.0

class ViewController: UIViewController {
    
    // MARK: - property
    private let onboardingTitle: UILabel = {
        let label = UILabel()
        label.text = "일정 시간마다 연락에 대한 \n알림을 받을 수 있어요"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 2
        return label
    }()
    private let onboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .red
        return imageView
    }()
    private lazy var nextButton: CommonButton = {
        let button = CommonButton()
        button.title = "다음"
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        render()
    }
    
    // MARK: - functions
    private func requestNotificationPermission(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow,Error in
            if didAllow {
                print("Push: 권한 허용")
            } else {
                print("Push: 권한 거부")
            }
        })
    }
    
    // MARK: - selectors
    @objc private func didTapNextButton() {
        print("didTapNextButton")
        requestNotificationPermission()
        self.navigationController?.pushViewController(AlarmSettingViewController(), animated: true)
    }
    
    
    // MARK: - configure
    private func render() {
        view.addSubview(onboardingTitle)
        onboardingTitle.translatesAutoresizingMaskIntoConstraints = false
        onboardingTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47).isActive = true
        onboardingTitle.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardingTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        
        view.addSubview(onboardingImageView)
        onboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        onboardingImageView.topAnchor.constraint(equalTo: onboardingTitle.bottomAnchor, constant: 35).isActive = true
        onboardingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        onboardingImageView.widthAnchor.constraint(equalToConstant: 250).isActive = true
        onboardingImageView.heightAnchor.constraint(equalToConstant: 480).isActive = true
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
    }
    
    private func configureUI() {
        navigationController?.navigationBar.isHidden = true
    }
    
    
}



