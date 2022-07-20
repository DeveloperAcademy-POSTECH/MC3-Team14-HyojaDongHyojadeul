//
//  ProfileModalCell.swift
//  AMaDda
//
//  Created by sanghyo on 2022/07/17.
//

import UIKit

final class ProfileModalCell: UICollectionViewCell {
    // MARK: - Property
    
    override var isSelected: Bool {
        didSet {
            DispatchQueue.main.async {
                self.checkMarkImageView.isHidden = !self.isSelected
            }
        }
    }
    var imageName: String = "Character1" {
        didSet {
            profileImageView.image = .load(name: imageName)
        }
    }
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    private let checkMarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .black
        imageView.isHidden = true
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAddSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configureAddSubviews() {
        contentView.addSubviews(profileImageView,
                                checkMarkImageView)
    }
    
    private func configureConstraints() {
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            profileImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            profileImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            profileImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            profileImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        
        checkMarkImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            checkMarkImageView.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 5),
            checkMarkImageView.trailingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: -5),
            checkMarkImageView.widthAnchor.constraint(equalToConstant: 40),
            checkMarkImageView.heightAnchor.constraint(equalTo: checkMarkImageView.widthAnchor),
        ])
    }
}
