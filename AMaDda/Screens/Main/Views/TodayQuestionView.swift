//
//  TodayQuestionView.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/18.
//

import Foundation
import UIKit

final class TodayQuestionView: UIView {
    // MARK: - property
    private let todayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 질문"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    private let todayCardView: UIView = {
        let view = UIView()
        return view
    }()
    var todayCardQuestionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    private let openingQuoteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.openingQuote
        imageView.tintColor = .black
        return imageView
    }()
    private let closingQuoteImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = ImageLiterals.closingQuote
        imageView.tintColor = .black
        return imageView
    }()
}

extension TodayQuestionView {
    // MARK: - configure
    func configureAddSubViewsTodayQuestionView() {
        addSubviews(todayTitleLabel,
                    todayCardView,
                    todayCardQuestionLabel,
                    openingQuoteImageView,
                    closingQuoteImageView)
    }
    func configureConstraintsTodayQuestionView() {
        todayTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            todayTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        
        todayCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayCardView.topAnchor.constraint(equalTo: todayTitleLabel.safeAreaLayoutGuide.bottomAnchor),
            todayCardView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            todayCardView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            todayCardView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        
        todayCardQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayCardQuestionLabel.centerYAnchor.constraint(equalTo: todayCardView.centerYAnchor),
            todayCardQuestionLabel.centerXAnchor.constraint(equalTo: todayCardView.centerXAnchor),
            todayCardQuestionLabel.widthAnchor.constraint(lessThanOrEqualTo: todayCardView.widthAnchor, constant: -50)
        ])
        
        openingQuoteImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            openingQuoteImageView.centerYAnchor.constraint(equalTo: todayCardQuestionLabel.topAnchor),
            openingQuoteImageView.trailingAnchor.constraint(equalTo: todayCardQuestionLabel.leadingAnchor , constant: -7)
        ])
        
        closingQuoteImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            closingQuoteImageView.centerYAnchor.constraint(equalTo: todayCardQuestionLabel.topAnchor),
            closingQuoteImageView.leadingAnchor.constraint(equalTo: todayCardQuestionLabel.trailingAnchor , constant: 7)
        ])
        
    }
}
