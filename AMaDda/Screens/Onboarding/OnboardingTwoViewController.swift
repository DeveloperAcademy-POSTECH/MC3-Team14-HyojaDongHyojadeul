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
    private lazy var onboardingTwoTitle: UILabel = {
        let label = UILabel()
        label.text = "며칠에 한 번 가족에게 연락하고 싶으세요?"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
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
    
    // MARK: stepper function
    @objc func stepperValueChanged(_ stepper: UIStepper) {
        notificationCount = Int(stepper.value)
        showNotification.text = "\(notificationCount)일"
    }
    
    // MARK: Life Cycle functions
    override func viewDidLoad() {
        super.viewDidLoad()
        render()
    }
    
    // MARK: Configures
    func render(){
        view.backgroundColor = .systemBackground
        
        view.addSubview(onboardingTwoTitle)
        onboardingTwoTitle.translatesAutoresizingMaskIntoConstraints = false
        onboardingTwoTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 48).isActive = true
        onboardingTwoTitle.trailingAnchor.constraint(equalTo: view.layoutMarginsGuide.trailingAnchor).isActive = true
        onboardingTwoTitle.leadingAnchor.constraint(equalTo: view.layoutMarginsGuide.leadingAnchor).isActive = true
        
        view.addSubview(showNotification)
        showNotification.translatesAutoresizingMaskIntoConstraints = false
        showNotification.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        showNotification.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(onboardingStepper)
        onboardingStepper.translatesAutoresizingMaskIntoConstraints = false
        onboardingStepper.bottomAnchor.constraint(equalTo: showNotification.bottomAnchor, constant: 145).isActive = true
        onboardingStepper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
}
