//
//  TodayQuestion.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/17.
//

import UIKit

final class TodayQuestion {
    private let todayQuestionData = TodayQuestionMockData.mockData
    // MARK: - property
    let todayQuestionView = UIView()
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

extension TodayQuestion {
    // MARK: - configure
    func configureAddSubViewsTodayQuestionView() {
        todayQuestionView.addSubview(todayTitleLabel)
        todayQuestionView.addSubview(todayCardView)
        todayCardView.addSubview(todayCardQuestionLabel)
    }
    func configureConstraintsTodayQuestionView() {
        todayTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayTitleLabel.topAnchor.constraint(equalTo: todayQuestionView.safeAreaLayoutGuide.topAnchor),
            todayTitleLabel.leadingAnchor.constraint(equalTo: todayQuestionView.safeAreaLayoutGuide.leadingAnchor)
        ])
        todayCardView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayCardView.topAnchor.constraint(equalTo: todayTitleLabel.safeAreaLayoutGuide.bottomAnchor, constant: 28),
            todayCardView.leadingAnchor.constraint(equalTo: todayQuestionView.safeAreaLayoutGuide.leadingAnchor),
            todayCardView.trailingAnchor.constraint(equalTo: todayQuestionView.safeAreaLayoutGuide.trailingAnchor),
            todayCardView.bottomAnchor.constraint(equalTo: todayQuestionView.safeAreaLayoutGuide.bottomAnchor)
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
