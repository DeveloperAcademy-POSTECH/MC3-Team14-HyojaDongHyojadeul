//
//  ProgressWithTextView.swift
//  AMaDda
//
//  Created by LeeSungHo on 2022/07/29.
//

import UIKit

class ProgressWithTextView: UIView {
//
//    let contactGoalCount = UserDefaults.standard.contactGoalCount
//    let userContactGoal = UserDefaults.standard.userContactGoal
    
    private let contactGoalCount = 2
    private let userContactGoal = 4
    private lazy var previousContactGoalCount = contactGoalCount - 1
    private lazy var previousProgress = Float(previousContactGoalCount) / Float(userContactGoal)
    private lazy var progress = Float(contactGoalCount) / Float(userContactGoal)
    
    // MARK: - property
    private lazy var feedBackprogressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = previousProgress
        progressView.trackImage = ImageLiterals.icBell
        return progressView
    }()
    private let progressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.icBell
        imageView.tintColor = .black
        return imageView
    }()
    private lazy var contactGoalCountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(contactGoalCount)회"
        return label
    }()
    private lazy var  userContactGoalLabel: UILabel = {
        let label = UILabel()
        label.text = "\(userContactGoal)회"
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
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                    self.feedBackprogressView.setProgress(self.progress, animated: true)
                }

            }
    }
    
    private func configureAddSubViews() {
        addSubviews(feedBackprogressView,
                          progressImage,
                          contactGoalCountLabel,
                          userContactGoalLabel
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
        
        contactGoalCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactGoalCountLabel.centerXAnchor.constraint(equalTo: progressImage.centerXAnchor),
            contactGoalCountLabel.topAnchor.constraint(equalTo: progressImage.bottomAnchor,constant: 5),
        ])
        
        userContactGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userContactGoalLabel.centerXAnchor.constraint(equalTo: feedBackprogressView.trailingAnchor),
            userContactGoalLabel.topAnchor.constraint(equalTo: progressImage .bottomAnchor, constant: 5),
        ])
    }
}
