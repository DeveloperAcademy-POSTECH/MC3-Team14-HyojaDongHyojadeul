//
//  EmptyTableViewCell.swift
//  AMaDda
//
//  Created by sanghyo on 2022/07/24.
//

import UIKit

final class EmptyTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let upperTableViewSpacing: CGFloat = 20
    private let mainTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "아직 기록중인 가족이 없어요"
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "가족을 추가해볼까요?"
        label.textAlignment = .center
        label.textColor = .gray
        return label
    }()
    private lazy var textStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [mainTitleLabel, subTitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.spacing = 10
        return stackView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
        configureAddSubviews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    private func configureUI() {
        contentView.backgroundColor = .systemBackground
    }
    
    private func configureAddSubviews() {
        contentView.addSubviews(textStackView)
    }
    
    private func configureConstraints() {
        textStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            textStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            textStackView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: -upperTableViewSpacing),
        ])
        
    }
}
