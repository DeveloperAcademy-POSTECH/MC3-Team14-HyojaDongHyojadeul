//
//  AddingViewController.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/18.
//

import UIKit

class AddingViewController: UIViewController {
    
    // MARK: - property
    private let addingTitle: UILabel = {
        let label = UILabel()
        label.text = "추가하기"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    private let imageView: UIImageView = {
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
    private let textField: UITextField = {
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
        view.addSubview(addingTitle)
        view.addSubview(imageView)
        view.addSubview(plusIcon)
        view.addSubview(createNicknameLabel)
        view.addSubview(textField)
        view.addSubview(underLineView)
        view.addSubview(textFieldLimitLabel)
        view.addSubview(addButton)
    }
    
    private func configureConstraints() {
        addingTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addingTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            addingTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: Size.leadingTrailingPadding),
        ])
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageView.topAnchor.constraint(equalTo: addingTitle.bottomAnchor, constant: 37),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
        ])
        plusIcon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            plusIcon.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 0),
            plusIcon.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 0),
            plusIcon.widthAnchor.constraint(equalToConstant: 25),
            plusIcon.heightAnchor.constraint(equalToConstant: 25),
        ])
        createNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createNicknameLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor,constant: 64),
            createNicknameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        textField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textField.topAnchor.constraint(equalTo: createNicknameLabel.bottomAnchor, constant: 20),
            textField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: Size.leadingTrailingPadding),
            textField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            textField.heightAnchor.constraint(equalToConstant: 60),
        ])
        underLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            underLineView.topAnchor.constraint(equalTo: textField.bottomAnchor),
            underLineView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            underLineView.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            underLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        textFieldLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldLimitLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            textFieldLimitLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
        ])
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -42),
            addButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            addButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
        ])
    }
}
