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
    private let connectLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘 연락했어요."
        return label
    }()
    private lazy var connectButton: UIButton = {
        let button = UIButton()
        button.setTitle("버튼", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        button.layer.cornerRadius = 27
        button.addTarget(self, action: #selector(didTapConnectButton), for: .touchUpInside)
        return button
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
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        contentView.layer.borderWidth = 1
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
        
        addSubview(connectLabel)
        connectLabel.translatesAutoresizingMaskIntoConstraints = false
        connectLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        connectLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        contentView.addSubview(connectButton)
        connectButton.translatesAutoresizingMaskIntoConstraints = false
        connectButton.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        connectButton.widthAnchor.constraint(equalToConstant: 54).isActive = true
        connectButton.heightAnchor.constraint(equalToConstant: 54).isActive = true
        connectButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15).isActive = true
    }
    
    // MARK: - selector
    @objc private func didTapConnectButton() {
        print("tap")
    }
}
