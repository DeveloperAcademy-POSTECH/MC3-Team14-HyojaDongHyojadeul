//
//  QustionTableViewCell.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/17.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    
    // MARK: - property
    private let familyImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        return imageView
    }()
    private let familyLabel: UILabel = {
        let label = UILabel()
        label.text = "엄마"
        return label
    }()
    
    // MARK: - init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        render()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - configure
    private func configureUI() {
        backgroundColor = .questionViewBackgroundColor
    }
    
    private func render() {
        addSubview(familyImage)
        familyImage.translatesAutoresizingMaskIntoConstraints = false
        familyImage.topAnchor.constraint(equalTo: topAnchor, constant: 15).isActive = true
        familyImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15).isActive = true
        familyImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        familyImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        addSubview(familyLabel)
        familyLabel.translatesAutoresizingMaskIntoConstraints = false
        familyLabel.topAnchor.constraint(equalTo: familyImage.bottomAnchor, constant: 3).isActive = true
        familyLabel.centerXAnchor.constraint(equalTo: familyImage.centerXAnchor).isActive = true
    }
}
