//
//  OnboardingGoalViewController.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/28.
//

import UIKit

class OnboardingGoalViewController: UIViewController {
    
    // MARK: Properties
    private let onboardingGoalTitleLabel: UILabel = {
        let label = UILabel()
        let attributedString = NSMutableAttributedString(string: "가족들에게 일주일에\n3회를 목표로 연락해보세요")
        let paragraphStyle = NSMutableParagraphStyle()
        
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.attributedText = attributedString
        label.textAlignment = .center
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))

        return label
    }()
    private let onboardingGoalImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "onboardingGoalImage.png")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let onboardingGoalTextLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16)
        label.text = "설정에서 목표횟수를 변경할 수 있어요"
        label.textColor = UIColor.onboardingGoalTextColor
        return label
    }()
    private lazy var startButton: CommonButton = {
        let button = CommonButton()
        let buttonTitle = "시작하기"
        button.setTitle(buttonTitle, for: .normal)
        button.setTitleColor(UIColor.systemBackground, for: .normal)
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
    @objc private func didTapStartButton() {
        let mainVC = MainViewController()
        navigationController?.pushViewController(mainVC, animated: true)
        navigationController?.isNavigationBarHidden = false
        UserDefaults.standard.checkedOnboarding = true
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
                         onboardingGoalImageView,
                         onboardingGoalTextLabel,
                         startButton)
    }
    
    private func configureConstraints(){
        onboardingGoalTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingGoalTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            onboardingGoalTitleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            onboardingGoalTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        
        onboardingGoalImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingGoalImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingGoalImageView.topAnchor.constraint(equalTo: onboardingGoalTitleLabel.bottomAnchor, constant: 34),
            onboardingGoalImageView.bottomAnchor.constraint(equalTo: startButton.topAnchor, constant: -130),
        ])
        
        onboardingGoalTextLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            onboardingGoalTextLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            onboardingGoalTextLabel.topAnchor.constraint(equalTo: onboardingGoalImageView.bottomAnchor, constant: 16)
        ])
        
        startButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            startButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42),
        ])
    }
}
