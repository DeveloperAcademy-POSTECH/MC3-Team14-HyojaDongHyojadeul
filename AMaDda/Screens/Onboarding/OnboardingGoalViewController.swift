//
//  OnboardingGoalViewController.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/28.
//

import UIKit

enum CycleViewModeForGoal: Equatable {
    case onboarding, setting
}

class OnboardingGoalViewController: UIViewController {
    var userContactGoal: Int = 3
    var cycleViewModeForGoal = CycleViewModeForGoal.onboarding
    
    // MARK: Properties
    private let onboardingGoalTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "가족들에게 일주일에\nn회 연락해보세요")
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.attributedText = attributedString
        label.textAlignment = .center
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        return label
    }()
    private lazy var startButton: CommonButton = {
        let button = CommonButton()
        let buttonTitle = cycleViewModeForGoal == .onboarding ? "시작하기" : "저장하기"
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapStartButton() {
        UserDefaults.standard.userContactGoal = userContactGoal
        switch cycleViewModeForGoal {
        case .onboarding:
            let mainVC = MainViewController()
            navigationController?.pushViewController(mainVC, animated: true)
            navigationController?.isNavigationBarHidden = false
            UserDefaults.standard.checkedOnboarding = true
        case .setting:
            navigationController?.popViewController(animated: true)
        }
    }
    
    // MARK: Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubView()
        configureConstraints()
    }
    
    // MARK: Configures
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureAddSubView() {
        view.addSubviews(onboardingGoalTitleLabel,
                        startButton)
    }
    
    private func configureConstraints(){
        onboardingGoalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingGoalTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            onboardingGoalTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            onboardingGoalTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
        ])
    }
}
