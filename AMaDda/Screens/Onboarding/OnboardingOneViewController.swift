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
    }
}
