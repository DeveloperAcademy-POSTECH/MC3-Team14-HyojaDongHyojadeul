//
//  FamilyTableCell.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/18.
//

import UIKit

class FamilyTableCell: UITableViewCell {
    
    static let reuseableIdentifier = "family"
    
    private enum Size {
        static let sideSpacing: CGFloat = 20.0
        static let topBottomSpacing: CGFloat = 25.0
        static let height: CGFloat = 120.0
        static let actionBtnSize: CGFloat = 55.0
    }
    
    
    // MARK: - property
    var item: FamilyMember? {
        didSet {
            self.familyNameLabel.text = item?.name
            self.familyDescriptionLabel.text = item?.description
            self.familyCharacterImageView.image = item?.characterImage
        }
    }
    
    private let familyCharacterImage: UIImage = {
        let familyCharacterImage = UIImage()
        return familyCharacterImage
    }()
    private let familyCharacterImageView: UIImageView = {
        let familyCharacterImageView = UIImageView()
        return familyCharacterImageView
    }()
    private let familyNameLabel: UILabel = {
        let familyNameLabel = UILabel()
        return familyNameLabel
    }()
    private let familyDescriptionLabel: UILabel = {
        let familyDescriptionText = UILabel()
        
        return familyDescriptionText
    }()
    private lazy var contactButton: UIButton = {
        let contactButton = UIButton()
        contactButton.setTitle("버튼", for: .normal)
        return contactButton
    }()
    
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor.amaddaBackgroundColor
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
        contentView.addSubview(familyCharacterImageView)
        contentView.addSubview(familyNameLabel)
        contentView.addSubview(familyDescriptionLabel)
        contentView.addSubview(contactButton)
    }
    
    private func configureConstraints() {
        
        familyCharacterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyCharacterImageView.leftAnchor.constraint(equalTo: leftAnchor, constant: Size.sideSpacing),
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
            familyDescriptionLabel.leftAnchor.constraint(equalTo: familyCharacterImageView.rightAnchor, constant: Size.sideSpacing),
            familyDescriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
        
        contactButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -Size.sideSpacing),
            contactButton.centerYAnchor.constraint(equalTo: centerYAnchor),
            contactButton.widthAnchor.constraint(equalToConstant: Size.actionBtnSize),
            contactButton.heightAnchor.constraint(equalToConstant: Size.actionBtnSize),
        ])
    }
    
    func configureUI() {
        contentView.backgroundColor = UIColor.cardBackgroundColor
        contentView.layer.cornerRadius = 20
        
        contactButton.layer.cornerRadius = Size.actionBtnSize/2
        contactButton.backgroundColor = .black
    }
}
