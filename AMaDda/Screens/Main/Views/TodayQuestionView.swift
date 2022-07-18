//
//  TodayQuestionView.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/18.
//

import Foundation
import UIKit

final class TodayQuestionView: UIView {
    private let todayQuestionData = TodayQuestionMockData.mockData
    // MARK: - property
    private let todayTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "오늘의 가족 Question"
        label.font = UIFont.systemFont(ofSize: 22, weight: .bold)
        return label
    }()
    private let todayCardView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        view.backgroundColor = UIColor.cardBackgroundColor
        return view
    }()
    private lazy var todayCardQuestionLabel: UILabel = {
        let label = UILabel()
        let randomQuestion = chooseRandomQuestion()
        label.text = randomQuestion
        return label
    }()
}

extension TodayQuestionView {
    // MARK: - configure
    func configureAddSubViewsTodayQuestionView() {
        addSubviews(todayTitleLabel, todayCardView, todayCardQuestionLabel)
    }
    func configureConstraintsTodayQuestionView() {
        todayTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayTitleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            todayTitleLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor)
        ])
        todayCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayCardView.topAnchor.constraint(equalTo: todayTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 28),
            todayCardView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            todayCardView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            todayCardView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
        todayCardQuestionLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayCardQuestionLabel.centerYAnchor.constraint(equalTo: todayCardView.centerYAnchor),
            todayCardQuestionLabel.centerXAnchor.constraint(equalTo: todayCardView.centerXAnchor)
        ])
    }
    // MARK: - function
    private func chooseRandomQuestion() -> String {
        guard let todayQuestion = todayQuestionData.randomElement() else { return "Question이 없습니다."}
        return todayQuestion.question
    }
}
