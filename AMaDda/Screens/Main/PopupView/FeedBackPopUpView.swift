//
//  FeedBackPopUpView.swift
//  AMaDda
//
//  Created by LeeSungHo on 2022/07/27.
//

import UIKit

protocol FeedBackPopUpViewDelegate: AnyObject {
    func removePopup()
}

class FeedBackPopUpView: UIView {
    
    weak var delegate: FeedBackPopUpViewDelegate?
    
    // MARK: - property
    private let feedBackTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "축하드려요!" // 추후에 바꿀것
        label.font = UIFont.systemFont(ofSize: 26, weight: .regular)
        return label
    }()
    private let feedBackSubTitle: UILabel = {
        let label = UILabel()
        label.text = "계획했던 연락 목표를\n달성했어요!"
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 15, weight: .regular)
        label.textColor = .gray
        return label
    }()
    private let feedBackImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .gray
        return imageView
    }()
    private let feedBackprogressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = 0.5
        return progressView
    }()
    private lazy var okButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .black
        button.setTitle("확인", for: .normal)
        button.layer.cornerRadius = 10
        button.tintColor = .white
        button.addTarget(self, action: #selector(didTapOkButton), for: .touchUpInside)
        return button
    }()
    private let progressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icBell
        imageView.tintColor = .black
        return imageView
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureAddSubViews()
        configureConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - selector
    @objc private func didTapOkButton() {
        delegate?.removePopup()
    }
    
    // MARK: - function
    
    // MARK: - configure
    private func configureUI() {
        layer.cornerRadius = 20
    }
    
    private func configureAddSubViews() {
        addSubviews(feedBackTitleLabel,
                    feedBackSubTitle,
                    feedBackImageView,
                    feedBackprogressView,
                    okButton,
                    progressImage
        )
    }
    
    private func configureConstraints() {
        feedBackTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedBackTitleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 43),
            feedBackTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
        
        feedBackSubTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedBackSubTitle.topAnchor.constraint(equalTo: feedBackTitleLabel.bottomAnchor, constant: 5),
            feedBackSubTitle.centerXAnchor.constraint(equalTo: feedBackTitleLabel.centerXAnchor),
        ])
        
        
        feedBackImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedBackImageView.topAnchor.constraint(equalTo: feedBackSubTitle.bottomAnchor,constant: 30),
            feedBackImageView.centerXAnchor.constraint(equalTo: feedBackSubTitle.centerXAnchor),
            feedBackImageView.widthAnchor.constraint(equalToConstant: 200),
            feedBackImageView.heightAnchor.constraint(equalToConstant: 200),
        ])
        
        feedBackprogressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedBackprogressView.topAnchor.constraint(equalTo: feedBackImageView.bottomAnchor, constant: 60),
            feedBackprogressView.centerXAnchor.constraint(equalTo: feedBackSubTitle.centerXAnchor),
            feedBackprogressView.widthAnchor.constraint(equalToConstant: 270),
            feedBackprogressView.heightAnchor.constraint(equalToConstant: 10),
        ])
        
        progressImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressImage.centerYAnchor.constraint(equalTo: feedBackprogressView.centerYAnchor),
            progressImage.centerXAnchor.constraint(equalTo: feedBackprogressView.leadingAnchor),
            progressImage.widthAnchor.constraint(equalToConstant: 50),
            progressImage.heightAnchor.constraint(equalToConstant: 50),
        ]
        )
        
        
        okButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            okButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -22),
            okButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            okButton.widthAnchor.constraint(equalToConstant: 270),
            okButton.heightAnchor.constraint(equalToConstant: 45),
        ])
    }
}
