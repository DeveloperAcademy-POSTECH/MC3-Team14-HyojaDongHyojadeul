//
//  ProgressWithTextView.swift
//  AMaDda
//
//  Created by LeeSungHo on 2022/07/29.
//

import UIKit

class ProgressWithTextView: UIView {
    
    let contactGoalCount = UserDefaults.standard.contactGoalCount
    
    // MARK: - property
    private let feedBackprogressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = 0.5
        return progressView
    }()
    private let progressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icBell
        imageView.tintColor = .black
        return imageView
    }()
    private lazy var currentContactCount: UILabel = {
        let label = UILabel()
        label.text = "0회"
        return label
    }()
    private lazy var  contactGoalLabel: UILabel = {
        let label = UILabel()
        label.text = "\(contactGoalCount)회"
        return label
    }()
    
    // MARK: - init
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        configureAddSubViews()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - function
    
    private func configureUI() {
        
    }
    
    private func configureAddSubViews() {
        addSubviews(feedBackprogressView,
                          progressImage,
                          currentContactCount,
                          contactGoalLabel
        )
    }
    
    private func configureLayoutConstraints() {
        
        feedBackprogressView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedBackprogressView.topAnchor.constraint(equalTo: topAnchor),
            feedBackprogressView.centerXAnchor.constraint(equalTo: centerXAnchor),
            feedBackprogressView.widthAnchor.constraint(equalTo: widthAnchor),
            feedBackprogressView.heightAnchor.constraint(equalTo: heightAnchor)
        ])
        
        progressImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            progressImage.centerYAnchor.constraint(equalTo: feedBackprogressView.centerYAnchor),
            progressImage.centerXAnchor.constraint(equalTo: feedBackprogressView.leadingAnchor),
            progressImage.widthAnchor.constraint(equalToConstant: 50),
            progressImage.heightAnchor.constraint(equalToConstant: 50),
        ])
        
        currentContactCount.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            currentContactCount.centerXAnchor.constraint(equalTo: progressImage.centerXAnchor),
            currentContactCount.topAnchor.constraint(equalTo: progressImage.bottomAnchor,constant: 5),
        ])
        
        contactGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactGoalLabel.centerXAnchor.constraint(equalTo: feedBackprogressView.trailingAnchor),
            contactGoalLabel.topAnchor.constraint(equalTo: progressImage .bottomAnchor, constant: 5),
        ])
    }
}
