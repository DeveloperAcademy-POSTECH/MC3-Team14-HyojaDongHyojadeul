//
//  EdittingViewController.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/19.
//

import UIKit

class EdittingViewController: UIViewController {
    
    private var maxLength = 5
    var contactNumber = ""
    private var familyMembers = [FamilyMemberData]()
    private let vc = ProfileModalViewController()
    var familyMember: FamilyMemberData?
    private lazy var placeholderTextCount = nickNameTextField.text?.count ?? 0
    private let nickNameTextFieldTag = 0
    private let contactNumberTextFieldTag = 1
    
    // MARK: - property
    
    private let editingTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "수정하기"
        label.font = UIFont.systemFont(ofSize: 34, weight: .bold)
        return label
    }()
    lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "\(familyMember?.characterImageName ?? "profile.circle")")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .lightGray
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    private let addLabel: UILabel = {
        let label = UILabel()
        label.text = "캐릭터 추가"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 15)
        return label
    }()
    private let createNicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "호칭"
        label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.text = familyMember?.name
        textField.tag = nickNameTextFieldTag
        return textField
    }()
    private let nicknameUnderLineView: UIView = {
         let view = UIView()
         view.backgroundColor = .lightGray
         return view
     }()
     private let createContactNumberLabel: UILabel = {
         let label = UILabel()
         label.text = "전화번호"
         label.font = UIFont.systemFont(ofSize: 20, weight: .regular)
         return label
     }()
     private lazy var contactNumberTextField: UITextField = {
         let textField = UITextField()
         textField.text = familyMember?.contactNumber
         textField.placeholder = "예시) 01012341234"
         textField.keyboardType = .numberPad
         textField.tag = contactNumberTextFieldTag
         return textField
     }()
     private let contactUnderLineView: UIView = {
         let view = UIView()
         view.backgroundColor = .lightGray
         return view
     }()
    private lazy var textFieldLimitLabel: UILabel = {
        let label = UILabel()
        label.text = "\(placeholderTextCount)/\(maxLength)"
        label.textColor = .lightGray
        return label
    }()
    private lazy var editButton: CommonButton = {
        let button = CommonButton()
        button.title = "저장하기"
        button.isDisabled = true
        button.addTarget(self, action: #selector(didTapEditButton), for: .touchUpInside)
        return button
    }()
    private lazy var deleteButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "삭제", style: .plain, target: self, action: #selector(didTapDeleteButton))
        button.tintColor = .red
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
        setupDelegate()
        self.title = "수정하기"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setTextFieldCount()
    }
    
    // MARK: - seletor
    
    @objc private func didTapEditButton() {
        guard let text = nickNameTextField.text else { return }
        guard let number = contactNumberTextField.text else { return }
        familyMembers = UserDefaults.standard.familyMembers
        familyMember?.name = text
        familyMember?.contactNumber = number
        familyMember?.updateFamilyMembers()
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func didTapDeleteButton() {
        makeRequestAlert(title: "가족 구성원을 삭제하시겠어요?", message: "한번 삭제하면 다시 복구할 수 없어요") { [self] _ in
            familyMember?.deleteFamilyMember()
            navigationController?.popViewController(animated: true)
        }
    }
    
    @objc private func didTapProfileImageView(_ gesture: UITapGestureRecognizer) {
        present(vc, animated: true)
    }
    
    @objc private func keyboardWillShow(notification:NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            UIView.animate(withDuration: 0.2, animations: {
                self.editButton.transform = CGAffineTransform(translationX: 0, y: -keyboardSize.height + 60)
                self.view.transform = CGAffineTransform(translationX: 0, y: -40)
            })
        }
    }
    
    @objc private func keyboardWillHide(notification:NSNotification) {
        UIView.animate(withDuration: 0.2, animations: {
            self.editButton.transform = .identity
            self.view.transform = .identity
        })
    }
    
    
    // MARK: - function
    private func setTextFieldCount() {
        placeholderTextCount = nickNameTextField.text?.count ?? 0
    }
    
    private func setupDelegate() {
        vc.delegate = self
        nickNameTextField.delegate = self
        contactNumberTextField.delegate = self
    }
    
    private func changeButtonEnableState() {
        let hasText = nickNameTextField.hasText
        let hasNum = contactNumberTextField.hasText
        let hasImage = profileImageView.image != ImageLiterals.btnProfile
        let canEabled = hasText && hasImage && hasNum

        editButton.isDisabled = !canEabled
    }
    
    private func setupTapGesture() {
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(didTapProfileImageView(_:)))
        tapGestureRecognizer.numberOfTapsRequired = 1
        tapGestureRecognizer.numberOfTouchesRequired = 1
        profileImageView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setCounter(count: Int) {
        textFieldLimitLabel.text = "\(count)/\(maxLength)"
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
        navigationItem.setRightBarButton(deleteButton, animated: false)
    }
    
    private func configureAddSubView() {
        view.addSubviews(profileImageView,
                         addLabel,
                         createNicknameLabel,
                         nickNameTextField,
                         nicknameUnderLineView,
                         textFieldLimitLabel,
                         createContactNumberLabel,
                         contactNumberTextField,
                         contactUnderLineView,
                         editButton)
    }
    
    private func configureConstraints() {
        
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            profileImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            profileImageView.widthAnchor.constraint(equalToConstant: 100),
            profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1.5),
        ])
        
        addLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addLabel.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 0),
            addLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
        ])
        
        createNicknameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createNicknameLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50),
            createNicknameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            createNicknameLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        nickNameTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nickNameTextField.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 50),
            nickNameTextField.centerYAnchor.constraint(equalTo: createNicknameLabel.centerYAnchor),
            nickNameTextField.leadingAnchor.constraint(equalTo: createNicknameLabel.trailingAnchor, constant: 10),
            nickNameTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            nickNameTextField.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        nicknameUnderLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            nicknameUnderLineView.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor),
            nicknameUnderLineView.leadingAnchor.constraint(equalTo: nickNameTextField.leadingAnchor),
            nicknameUnderLineView.trailingAnchor.constraint(equalTo: nickNameTextField.trailingAnchor),
            nicknameUnderLineView.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        textFieldLimitLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textFieldLimitLabel.topAnchor.constraint(equalTo: nickNameTextField.bottomAnchor, constant: 5),
            textFieldLimitLabel.trailingAnchor.constraint(equalTo: nickNameTextField.trailingAnchor),
        ])
        
        createContactNumberLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            createContactNumberLabel.topAnchor.constraint(equalTo: nicknameUnderLineView.bottomAnchor, constant: 30),
            createContactNumberLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            createContactNumberLabel.widthAnchor.constraint(equalToConstant: 80)
        ])
        
        contactNumberTextField.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactNumberTextField.topAnchor.constraint(equalTo: nicknameUnderLineView.bottomAnchor, constant: 30),
            contactNumberTextField.centerYAnchor.constraint(equalTo: createContactNumberLabel.centerYAnchor),
            contactNumberTextField.leadingAnchor.constraint(equalTo: createContactNumberLabel.trailingAnchor, constant: 10),
            contactNumberTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            contactNumberTextField.heightAnchor.constraint(equalToConstant: 35),
        ])
        
        contactUnderLineView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactUnderLineView.topAnchor.constraint(equalTo: contactNumberTextField.bottomAnchor),
            contactUnderLineView.leadingAnchor.constraint(equalTo: contactNumberTextField.leadingAnchor),
            contactUnderLineView.trailingAnchor.constraint(equalTo: contactNumberTextField.trailingAnchor),
            contactUnderLineView.heightAnchor.constraint(equalToConstant: 1)
        ])
        
        editButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            editButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -42),
            editButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            editButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
        ])
        
    }
}

extension EdittingViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == nickNameTextFieldTag {
            setCounter(count: textField.text?.count ?? 0)
        }
        changeButtonEnableState()
    }
}

extension EdittingViewController: ProfileModalViewDelegate {
    func registerSelectedCharacter(imageName: String) {
        familyMember?.characterImageName = imageName
        DispatchQueue.main.async {
            self.profileImageView.image = UIImage(named: imageName)
            self.changeButtonEnableState()
        }
    }
}
