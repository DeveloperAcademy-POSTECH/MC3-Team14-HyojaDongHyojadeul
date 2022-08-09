//
//  FamilyTableCell.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/18.
//

import UIKit
import SwiftUI

protocol FamilyTableCellDelegate: AnyObject {
    func displayActionSheet(familyMember: FamilyMemberData)
}

class FamilyTableCell: UITableViewCell {
    
    // TODO: cell 터치시 editing view 열기
    private enum Size {
        static let sideSpacing: CGFloat = 30.0
        static let topBottomSpacing: CGFloat = 25.0
        static let height: CGFloat = 120.0
        static let actionBtnSize: CGFloat = 70.0
    }
    
    // MARK: - property
    
    weak var delegate: FamilyTableCellDelegate?
    
    var item: FamilyMemberData? {
        didSet {
            self.familyNameLabel.text = item?.name
            self.familyDescriptionLabel.text = item?.contactTermString
            self.familyCharacterImageView.image = UIImage.load(name: item?.characterImageName ?? "Character1")
        }
    }
    
    private let familyCharacterImageView = UIImageView()
    private let familyNameLabel = UILabel()
    private let familyDescriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    private lazy var callTapGesture: UITapGestureRecognizer = {
        let gesture = UITapGestureRecognizer()
        gesture.addTarget(self, action:  #selector(didTapContactButton(_:)))
        gesture.numberOfTapsRequired = 1
        return gesture
    }()
    private lazy var callButtonImageView: UIImageView = {
        let imageView = UIImageView()
        
        // TODO: catsole 사이즈 바꾸기 & 터치 영역 키우기
        imageView.image = ImageLiterals.catSole
        imageView.layer.borderWidth = 3
        imageView.image?.resize(to: CGSize(width: 50, height: 50))
//        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(callTapGesture)
        return imageView
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
                                callButtonImageView)
    }
    
    private func configureConstraints() {
        
        familyCharacterImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyCharacterImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Size.sideSpacing),
            familyCharacterImageView.topAnchor.constraint(equalTo: topAnchor, constant: Size.topBottomSpacing),
            familyCharacterImageView.heightAnchor.constraint(equalToConstant: 60),
            familyCharacterImageView.widthAnchor.constraint(equalToConstant: 60),
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
        
        callButtonImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            callButtonImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -Size.sideSpacing),
            callButtonImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            callButtonImageView.widthAnchor.constraint(equalToConstant: Size.actionBtnSize),
            callButtonImageView.heightAnchor.constraint(equalToConstant: Size.actionBtnSize),
        ])
    }
    
    private func configureUI() {
        backgroundColor = .systemBackground
        contentView.layer.cornerRadius = 20
        
        callButtonImageView.layer.cornerRadius = Size.actionBtnSize/2
        callButtonImageView.backgroundColor = .white
    }
    
//     MARK: - selector
    @objc func didTapContactButton(_ gesture: UITapGestureRecognizer) {
        guard let item = item else { fatalError() }
        delegate?.displayActionSheet(familyMember: item)
    }
}
