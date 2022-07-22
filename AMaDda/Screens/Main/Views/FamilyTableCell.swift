//
//  FamilyTableCell.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/18.
//

import UIKit

class FamilyTableCell: UITableViewCell {
    private enum Size {
        static let sideSpacing: CGFloat = 30.0
        static let topBottomSpacing: CGFloat = 25.0
        static let height: CGFloat = 120.0
        static let actionBtnSize: CGFloat = 55.0
    }
    
    // MARK: - property
    var item: FamilyMemberData? {
        didSet {
            self.familyNameLabel.text = item?.name
//            self.familyDescriptionLabel.text = item?.lastContact
//            self.familyCharacterImageView.image = item?.characterImage
        }
    }
    
    private let familyCharacterImage = UIImage()
    private let familyCharacterImageView = UIImageView()
    private let familyNameLabel = UILabel()
    private let familyDescriptionLabel = UILabel()
    private let callImage: UIImage = {
        let configuration = UIImage.SymbolConfiguration(textStyle: .title1)
        let image = UIImage(systemName: "phone.fill", withConfiguration: configuration)
        return image!
    }()
    private lazy var contactButton: UIButton = {
        let contactButton = UIButton()
        contactButton.setImage(callImage, for: .normal)
        contactButton.tintColor = .white
        return contactButton
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureAddSubViews()
        configureConstraints()
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    private func configureAddSubViews() {
        contentView.addSubviews(familyCharacterImageView,
                               familyNameLabel,
                               familyDescriptionLabel,
                               contactButton)
    }
    
    private func configureConstraints() {
        
        familyCharacterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyCharacterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.sideSpacing),
            familyCharacterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Size.topBottomSpacing),
            familyCharacterImageView.heightAnchor.constraint(equalToConstant: 60),
            familyCharacterImageView.widthAnchor.constraint(equalToConstant: 50),
        ])
        
        familyNameLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyNameLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -Size.topBottomSpacing),
            familyNameLabel.centerXAnchor.constraint(equalTo: familyCharacterImageView.centerXAnchor),
        ])
        
        familyDescriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyDescriptionLabel.leadingAnchor.constraint(equalTo: familyCharacterImageView.trailingAnchor, constant: Size.sideSpacing),
            familyDescriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.sideSpacing),
            contactButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            contactButton.widthAnchor.constraint(equalToConstant: Size.actionBtnSize),
            contactButton.heightAnchor.constraint(equalToConstant: Size.actionBtnSize),
        ])
    }
    
    func configureUI() {
        backgroundColor = .systemBackground
        
//        contentView.backgroundColor = UIColor.cardBackgroundColor
        contentView.layer.cornerRadius = 20
        
        contactButton.layer.cornerRadius = Size.actionBtnSize/2
        contactButton.backgroundColor = .black
    }
}
