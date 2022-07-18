//
//  AddingViewController.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/18.
//

import UIKit

class AddingViewController: UIViewController {
    
    // MARK: - property
    private let addingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "추가하기"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.btnProfile
        imageView.tintColor = .lightGray
        return imageView
    }()
    private let plusIcon: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icPlus
        imageView.tintColor = .gray
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        return imageView
    }()
    private let createNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "어떻게 부르고 싶나요?"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예시) 아버지, 엄마, 세젤예 우리엄마"
        return textField
    }()
    private let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    private let textFieldLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "0/10"
        label.textColor = .lightGray
        return label
    }()
    private let addButton: CommonButton = {
        let button = CommonButton()
        button.title = "추가하기"
        return button
    }()
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubView()
        configureConstraints()
    }

    // MARK: - configure
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureAddSubView() {
        view.addSubview(addingTitleLabel)
        view.addSubview(profileImageView)
        view.addSubview(plusIcon)
        view.addSubview(createNicknameLabel)
        view.addSubview(nickNameTextField)
        view.addSubview(underLineView)
        view.addSubview(textFieldLimitLabel)
        view.addSubview(addButton)
    }
    
    private func configureConstraints() {
        addingTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addingTitleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addingTitleLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: Size.leadingTrailingPadding),
        ])
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: addingTitleLabel.bottomAnchor, constant: 37),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusIcon.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0),
            plusIcon.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 0),
            plusIcon.widthAnchor.constraint(equalToConstant: 25),
            plusIcon.heightAnchor.constraint(equalToConstant: 25),
        ])
        createNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createNicknameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor,constant: 64),
            createNicknameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: createNicknameLabel.bottomAnchor, constant: 20),
            nickNameTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: Size.leadingTrailingPadding),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 50),
        ])
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underLineView.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor),
            underLineView.leadingAnchor.constraint(equalTo: nickNameTextField.leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: nickNameTextField.trailingAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        textFieldLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldLimitLabel.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 5),
            textFieldLimitLabel.trailingAnchor.constraint(equalTo: nickNameTextField.trailingAnchor),
        ])
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -42),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
        ])
    }
}
