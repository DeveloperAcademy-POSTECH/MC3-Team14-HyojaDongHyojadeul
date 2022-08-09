//
//  ProgressWithTextView.swift
//  AMaDda
//
//  Created by LeeSungHo on 2022/07/29.
//

import UIKit

class ProgressWithTextView: UIView {

    private lazy var contactGoalCount = UserDefaults.standard.contactGoalCount == 0 ? 1 : UserDefaults.standard.contactGoalCount
    var userContactGoal = UserDefaults.standard.userContactGoal
    private lazy var previousContactGoalCount = contactGoalCount - 1
    private lazy var previousProgress = Float(previousContactGoalCount) / Float(userContactGoal)
    private lazy var progress = Float(contactGoalCount) / Float(userContactGoal)
    private let width = 220
    
    var ConsArray: [NSLayoutConstraint] = []
    
    // MARK: - property
    private lazy var feedBackprogressView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.progressViewStyle = .default
        progressView.progress = previousProgress
        return progressView
    }()
    private let progressImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.FeedBackLow1
        imageView.tintColor = .black
        return imageView
    }()
    private let zeroCountLabel: UILabel = {
        let label = UILabel()
        label.text = "0회"
        return label
    }()
    private lazy var contactGoalCountLabel: UILabel = {
        let label = UILabel()
        label.text = "\(contactGoalCount-1)회"
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
        setUpNotification()
        configureAddSubViews()
        configureLayoutConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - selector
    @objc private func showPopUpAnimation() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            UIView.animate(withDuration: 1, delay: 0, options: .curveLinear) {
                NSLayoutConstraint.deactivate(self.ConsArray)
                _ = self.ConsArray.popLast()
                let leadingCons = self.progressImage.centerXAnchor.constraint(equalTo: self.feedBackprogressView.leadingAnchor, constant: CGFloat(self.progress * Float(self.width)))
                self.ConsArray.append(leadingCons)
                NSLayoutConstraint.activate(self.ConsArray)
                self.layoutIfNeeded()
                self.feedBackprogressView.setProgress(self.progress, animated: true)
                self.contactGoalCountLabel.text = "\(self.contactGoalCount)회"
            }
        }
    }
    
    // MARK: - function
    func updateProgressValues() {
        userContactGoal = UserDefaults.standard.userContactGoal
        previousProgress = Float(previousContactGoalCount) / Float(userContactGoal)
        progress = Float(contactGoalCount) / Float(userContactGoal)
        userContactGoalLabel.text = "\(userContactGoal)회"
        feedBackprogressView.progress = previousProgress
        updateProgressImageLayout()
    }
    
    private func updateProgressImageLayout() {
        NSLayoutConstraint.deactivate(ConsArray)
        _ = ConsArray.popLast()
        let leadingCons = progressImage.centerXAnchor.constraint(equalTo: feedBackprogressView.leadingAnchor, constant: CGFloat(previousProgress * Float(width)))
        ConsArray.append(leadingCons)
        NSLayoutConstraint.activate(ConsArray)
    }
    
    private func setUpNotification() {
        NotificationCenter.default.addObserver(self, selector: #selector(showPopUpAnimation), name: NSNotification.Name("showPopUp"), object: nil)
    }
    
    private func configureAddSubViews() {
        addSubviews(feedBackprogressView,
                    progressImage,
                    zeroCountLabel,
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

        let centerYCons = progressImage.centerYAnchor.constraint(equalTo: feedBackprogressView.centerYAnchor)
        let leadingCons = progressImage.centerXAnchor.constraint(equalTo: feedBackprogressView.leadingAnchor, constant: CGFloat(previousProgress * Float(width)))
        let witdhCons = progressImage.widthAnchor.constraint(equalToConstant: 75)
        let heightCons = progressImage.heightAnchor.constraint(equalToConstant: 75)

        ConsArray = [centerYCons, witdhCons, heightCons, leadingCons]
        NSLayoutConstraint.activate(ConsArray)
        
        zeroCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            zeroCountLabel.centerXAnchor.constraint(equalTo: feedBackprogressView.leadingAnchor),
            zeroCountLabel.topAnchor.constraint(equalTo: progressImage.bottomAnchor),
        ])
        
        contactGoalCountLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contactGoalCountLabel.centerXAnchor.constraint(equalTo: progressImage.centerXAnchor),
            contactGoalCountLabel.topAnchor.constraint(equalTo: progressImage.bottomAnchor),
        ])
        
        userContactGoalLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userContactGoalLabel.centerXAnchor.constraint(equalTo: feedBackprogressView.trailingAnchor),
            userContactGoalLabel.topAnchor.constraint(equalTo: progressImage .bottomAnchor),
        ])
    }
}
