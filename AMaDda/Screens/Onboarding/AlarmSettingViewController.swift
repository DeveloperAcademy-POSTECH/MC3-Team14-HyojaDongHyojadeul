//
//  AlarmSettingView.swift
//  AMaDdaTT
//
//  Created by LeeSungHo on 2022/07/15.
//

import UIKit

class AlarmSettingViewController: UIViewController {
    
    var alarmCount = 3
    
    // MARK: - Property
    
    private let alarmSettingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "며칠에 한 번 가족에게\n연락하고 싶으세요?"
        label.font = .boldSystemFont(ofSize: 25)
        label.numberOfLines = 2
        return label
    }()
    lazy var alarmCycleLabel: UILabel = {
        let label = UILabel()
        label.text = "\(alarmCount)일"
        label.font = .systemFont(ofSize: 40)
        return label
    }()
    private lazy var stepper: UIStepper = {
        let stepper = UIStepper()
        stepper.value = 3
        stepper.maximumValue = 7
        stepper.minimumValue = 1
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
        return stepper
    }()
    private lazy var startButton: CommonButton = {
        let button = CommonButton()
        button.title = "시작하기"
        button.addTarget(self, action: #selector(didTapStartButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        render()
    }
    
    // MARK: - Function
    private func render() {
        view.addSubview(alarmSettingTitleLabel)
        alarmSettingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        alarmSettingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 47).isActive = true
        alarmSettingTitleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alarmSettingTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        
        view.addSubview(alarmCycleLabel)
        alarmCycleLabel.translatesAutoresizingMaskIntoConstraints = false
        alarmCycleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        alarmCycleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        view.addSubview(stepper)
        stepper.translatesAutoresizingMaskIntoConstraints = false
        stepper.topAnchor.constraint(equalTo: alarmCycleLabel.bottomAnchor, constant: 96).isActive = true
        stepper.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        view.addSubview(startButton)
        startButton.translatesAutoresizingMaskIntoConstraints = false
        startButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        startButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -40).isActive = true
    }
    
    // MARK: - Configure
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    
    // MARK: - Selectors
    @objc private func stepperValueChanged(_ stepper: UIStepper) {
        alarmCount = Int(stepper.value)
        alarmCycleLabel.text = "\(alarmCount)일"
    }
    
    @objc private func didTapStartButton() {
        print("didTapStartButton")
        navigationController?.pushViewController(MainViewController(), animated: true)
    }
    
}
