//
//  AddingViewController.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/18.
//

import UIKit

class AddingViewController: UIViewController {
    
    private var maxLength = 10
    
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
        imageView.isUserInteractionEnabled = true
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
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "예시) 아버지, 엄마, 세젤예 우리엄마"
        textField.delegate = self
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
    private lazy var addButton: CommonButton = {
        let button = CommonButton()
        button.title = "추가하기"
        button.addTarget(self, action: #selector(didTapAddButton), for: .touchUpInside)
        return button
    }()
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubView()
        configureConstraints()
        hidekeyboardWhenTappedAround()
        setupNotificationCenter()
        setupTapGesture()
    }
    
    // MARK: - seletor
    
    @objc private func didTapAddButton() {
        guard let text = nickNameTextField.text else { return }
        print(text)
        // TODO: 이미지경로(String) 이랑 text(String) 를 array에 append하고 그 array를 UserDefault에 저장
    }
    
    @objc private func didTapProfileImageView(_ gesture: UITapGestureRecognizer) {
        print("gesture")
    }
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.addButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 60)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.addButton.transform = .identity
        })
    }
    
    // MARK: - function
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setCounter(count: Int) {
        textFieldLimitLabel.text = "\(count)/10"
        checkMaxLength(textField: nickNameTextField, maxLength: maxLength)
    }

    private func checkMaxLength(textField: UITextField, maxLength: Int) {
        if (textField.text?.count ?? 0 > maxLength) {
            textField.deleteBackward()
        }
    }
    
    private func setupNotificationCenter() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
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


extension AddingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        setCounter(count: textField.text?.count ?? 0)
    }
}
