//
//  OnboardingOne.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/18.
//

import UIKit

class OnboardingOneViewController: UIViewController {
    // MARK: Properties
    private lazy var FirstOnboardTitle: UILabel = {
        let label = UILabel()
        label.text = "일정시간마다 연락에 대한 알림을 받을 수 있어요"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private lazy var FirstOnboardingview: UIImageView = {
        let FirstOnboardingview = UIImageView()
        FirstOnboardingview.image = UIImage(named: "onboardingImage.png")
        return FirstOnboardingview
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton()
        button.setTitle("다음", for: UIControl.State.normal)
        button.setTitleColor(.systemBlue, for: .normal)
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
        view.addSubview(FirstOnboardTitle)
        view.addSubview(FirstOnboardingview)
        view.addSubview(nextButton)
    }
    
    func configureConstraints(){
        view.backgroundColor = .systemBackground
        
        FirstOnboardTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            FirstOnboardTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48),
            FirstOnboardTitle.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor),
            FirstOnboardTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor)
        ])
        
        FirstOnboardingview.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            FirstOnboardingview.topAnchor.constraint(equalTo: FirstOnboardTitle.bottomAnchor, constant: 34),
            FirstOnboardingview.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            FirstOnboardingview.widthAnchor.constraint(equalToConstant: 240),
            FirstOnboardingview.heightAnchor.constraint(equalToConstant: 480)
        ])
        
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            nextButton.topAnchor.constraint(equalTo: FirstOnboardingview.bottomAnchor, constant: 34)
        ])
    }
}
