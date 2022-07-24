//
//  OnboardingOne.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/18.
//

import UIKit

class OnboardingOneViewController: UIViewController {
    
    // MARK: - Properties
    
    private let firstOnboardTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "일정시간마다 연락에 대한\n알림을 받을 수 있어요")
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.attributedText = attributedString
        label.textAlignment = .center
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        
        return label
    }()
    private let firstOnboardingImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboardingImage.png")
        return imageView
    }()
    private lazy var nextButton: CommonButton = {
        let button = CommonButton()
        button.setTitle("다음", for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubView()
        configureConstraints()
    }
    
    // MARK: - Configures
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureAddSubView() {
        view.addSubviews(firstOnboardTitleLabel,
                         firstOnboardingImageView,
                         nextButton)
    }
    
    func configureConstraints(){        
        firstOnboardTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstOnboardTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            firstOnboardTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            firstOnboardTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        
        firstOnboardingImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstOnboardingImageView.topAnchor.constraint(equalTo: firstOnboardTitleLabel.bottomAnchor, constant: 34),
            firstOnboardingImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstOnboardingImageView.widthAnchor.constraint(equalToConstant: 240),
            firstOnboardingImageView.heightAnchor.constraint(equalToConstant: 480),
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
        ])
    }
    
    // MARK: - selector
    
    @objc private func didTapNextButton(){
        notificationAuthorizationRequest()
        // TODO: onboarding2 로 이동
    }
}

// MARK: - extensions

extension OnboardingOneViewController {
    private func notificationAuthorizationRequest(){
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.badge, .alert, .sound]) { granted, error in
            if let error = error {
                print("request authorization failed: \(error)")
            }
            // TODO: sprint1 때에는 granted 설정에 상관 없이 onboarding2로 이동
            // TODO: sprint2 때에는 분기점 생성
        }
    }
}
