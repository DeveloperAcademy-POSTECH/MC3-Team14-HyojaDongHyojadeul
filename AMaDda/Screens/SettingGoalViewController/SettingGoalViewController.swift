//
//  SettingGoalViewController.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/08/09.
//

import UIKit

protocol MainSettingGoalDelegate: AnyObject {
    func changeGoal()
}

class SettingGoalViewController: UIViewController {
    var userContactGoal: Int = 3
    
    var delegate: MainSettingGoalDelegate?
    
    // MARK: Properties
    private let onboardingGoalTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "일주일에 몇 회 가족에게\n연락하는 것을 목표로 하시나요?")
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
        label.text = "\(userContactGoal)회"
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
    private lazy var startButton: CommonButton = {
        let button = CommonButton()
        let buttonTitle = "저장하기"
        button.setTitle(buttonTitle, for: .normal)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: stepper function
    @objc private func stepperValueChanged(_ stepper: UIStepper) {
        userContactGoal = Int(stepper.value)
        showNotificationLabel.text = "\(userContactGoal)회"
    }
    
    @objc private func didTapStartButton() {
        UserDefaults.standard.userContactGoal = userContactGoal
        delegate?.changeGoal()
        navigationController?.popViewController(animated: true)
    }
    
    // MARK: Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubView()
        configureConstraints()
    }
    
    // MARK: - Functions
    private func checkCycleViewModeForGoal() {
        let goalNumber = UserDefaults.standard.userContactGoal
        onboardingStepper.value = Double(goalNumber)
        showNotificationLabel.text = "\(goalNumber)회"
    }
    
    // MARK: Configures
    private func configureUI() {
        view.backgroundColor = .systemBackground
        checkCycleViewModeForGoal()
    }
    
    private func configureAddSubView() {
        view.addSubviews(onboardingGoalTitleLabel,
                        showNotificationLabel,
                        onboardingStepper,
                        startButton)
    }
    
    private func configureConstraints(){
        onboardingGoalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingGoalTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            onboardingGoalTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            onboardingGoalTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
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
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
        ])
    }
}
