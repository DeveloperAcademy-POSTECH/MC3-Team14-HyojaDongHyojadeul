//
//  OnboardingTwoViewController.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/19.
//

import UIKit

enum CycleViewMode: Equatable {
    case onboarding, setting
}

final class OnboardingTwoViewController: UIViewController {
    
    var notificationCount: Int = 3
    var cycleViewMode = CycleViewMode.onboarding
    
    // MARK: Properties
    private let onboardingTwoTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "며칠에 한 번 가족에게\n연락하고 싶으세요?")
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.attributedText = attributedString
        label.textAlignment = .center
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        return label
    }()
    private lazy var showNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "\(notificationCount)일"
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    private lazy var onboardingStepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 3
        stepper.maximumValue = 7
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    private lazy var nextButton: CommonButton = {
        let button = CommonButton()
        let buttonTitle = cycleViewMode == .onboarding ? "다음" : "저장하기"
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: stepper function
    @objc private func stepperValueChanged(_ stepper: UIStepper) {
        notificationCount = Int(stepper.value)
        showNotificationLabel.text = "\(notificationCount)일"
    }
    
    @objc private func didTapNextButton() {
        switch cycleViewMode {
        case .onboarding:
            let onboardingGoalVC = OnboardingGoalViewController()
            navigationController?.pushViewController(onboardingGoalVC, animated: true)
            navigationController?.isNavigationBarHidden = true
            UserDefaults.standard.checkedOnboarding = true
        case .setting:
            navigationController?.popViewController(animated: true)
        }
        UserDefaults.standard.notificationCount = notificationCount
    }
    
    // MARK: Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubView()
        configureConstraints()
    }
    
    // MARK: - Functions
    private func checkCycleViewMode() {
        if case CycleViewMode.setting = cycleViewMode {
            guard let notificationCycle = UserDefaults.standard.notificationCount else { return }
            onboardingStepper.value = Double(notificationCycle)
            showNotificationLabel.text = "\(notificationCycle)일"
        }
    }
    
    // MARK: Configures
    private func configureUI() {
        view.backgroundColor = .systemBackground
        checkCycleViewMode()
    }
    
    private func configureAddSubView() {
        view.addSubviews(onboardingTwoTitleLabel,
                        showNotificationLabel,
                        onboardingStepper,
                        nextButton)
    }
    
    private func configureConstraints(){
        onboardingTwoTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingTwoTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            onboardingTwoTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            onboardingTwoTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        
        showNotificationLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showNotificationLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showNotificationLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        onboardingStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingStepper.topAnchor.constraint(equalTo: showNotificationLabel.bottomAnchor, constant: 104),
            onboardingStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
        ])
        
    }
}
