//
//  OnboardingOne.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/18.
//

import UIKit

class OnboardingOneViewController: UIViewController {
    // MARK: Properties
    private let firstOnboardTitle: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        
        let attributedString = NSMutableAttributedString(string: "일정시간마다 연락에 대한\n알림을 받을 수 있어요")
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 10
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value:paragraphStyle, range:NSMakeRange(0, attributedString.length))
        label.attributedText = attributedString
        
        return label
    }()
    
    private let firstOnboardingview: UIImageView = {
        let firstOnboardingview = UIImageView()
        firstOnboardingview.image = UIImage(named: "onboardingImage.png")
        return firstOnboardingview
    }()
    
    private let nextButton: CommonButton = {
        let button = CommonButton()
        button.setTitle("다음", for: UIControl.State.normal)
        // TODO: Button Function을 필요로 한다.
        return button
    }()
    
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
        view.addSubview(firstOnboardTitle)
        view.addSubview(firstOnboardingview)
        view.addSubview(nextButton)
    }
    
    func configureConstraints(){
        view.backgroundColor = .systemBackground
        
        firstOnboardTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstOnboardTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            firstOnboardTitle.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: Size.leadingTrailingPadding),
            firstOnboardTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding)
        ])
        
        firstOnboardingview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            firstOnboardingview.topAnchor.constraint(equalTo: firstOnboardTitle.bottomAnchor, constant: 34),
            firstOnboardingview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            firstOnboardingview.widthAnchor.constraint(equalToConstant: 240),
            firstOnboardingview.heightAnchor.constraint(equalToConstant: 480)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -42)
        ])
    }
}
