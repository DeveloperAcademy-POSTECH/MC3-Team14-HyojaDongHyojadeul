//
//  OnboardingTwoViewController.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/19.
//

import UIKit

class OnboardingTwoViewController: UIViewController {
    // MARK: Properties
    private lazy var onboardingTwoTitle: UILabel = {
        let label = UILabel()
        label.text = "며칠에 한 번 가족에게 연락하고 싶으세요?"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

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

    }
}
