//
//  OnboardingTwoViewController.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/19.
//

import UIKit

class OnboardingTwoViewController: UIViewController {
    
    var notificationCount = 3
    
    // MARK: Properties
    private let onboardingTwoTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: "며칠에 한 번 가족에게 연락하고\n싶으세요?")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        return label
    }()
    
    private lazy var showNotification: UILabel = {
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
    
    private let startButton: CommonButton = {
        let button = CommonButton()
        button.setTitle("시작하기", for: .normal)
        // TODO: Button Function을 필요로 한다.
        return button
    }()
    
    // MARK: stepper function
    @objc func stepperValueChanged(_ stepper: UIStepper) {
        notificationCount = Int(stepper.value)
        showNotification.text = "\(notificationCount)일"
    }
    
    // MARK: Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubView()
        configureConstraints()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureAddSubView() {
        view.addSubviews(onboardingTwoTitle,
                        showNotification,
                        onboardingStepper,
                        startButton)
    }
    
    // MARK: Configures
    func configureConstraints(){
        onboardingTwoTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingTwoTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            onboardingTwoTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            onboardingTwoTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        
        showNotification.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            showNotification.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            showNotification.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
        
        onboardingStepper.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingStepper.topAnchor.constraint(equalTo: showNotification.bottomAnchor, constant: 104),
            onboardingStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
        ])
    }
}
