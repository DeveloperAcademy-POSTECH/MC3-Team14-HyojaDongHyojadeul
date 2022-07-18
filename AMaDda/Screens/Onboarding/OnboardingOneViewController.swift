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
        button.frame = CGRect(x: 15, y: -50, width: 300, height: 500)
        // TODO: Button Function을 필요로 한다.
        // button.addTarget(self, action: #selector(requestNotificationPermission), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    func render(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(FirstOnboardTitle)
        FirstOnboardTitle.translatesAutoresizingMaskIntoConstraints = false
        FirstOnboardTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        FirstOnboardTitle.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        FirstOnboardTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
        view.addSubview(FirstOnboardingview)
        FirstOnboardingview.translatesAutoresizingMaskIntoConstraints = false
        FirstOnboardingview.topAnchor.constraint(equalTo: FirstOnboardTitle.bottomAnchor, constant: 34).isActive = true
        FirstOnboardingview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        FirstOnboardingview.widthAnchor.constraint(equalToConstant: 240).isActive = true
        FirstOnboardingview.heightAnchor.constraint(equalToConstant: 480).isActive = true
        
        view.addSubview(nextButton)
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        nextButton.topAnchor.constraint(equalTo: FirstOnboardingview.bottomAnchor, constant: 34).isActive = true
    }
}
