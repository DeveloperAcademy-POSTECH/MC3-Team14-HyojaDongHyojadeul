//
//  MainViewController.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/17.
//

import UIKit

final class MainViewController: UIViewController {
    private let todayQuestion = TodayQuestion()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubViews()
        configureConstarints()
    }
}

extension MainViewController {
    private func configureUI() {
        guard let view = self.view else { return }
        view.backgroundColor = UIColor.amaddaBackgroundColor
    }
    private func configureAddSubViews() {
        guard let view = self.view else { return }
        view.addSubview(todayQuestion.todayQuestionView)
    }
    private func configureConstarints() {
        todayQuestion.todayQuestionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayQuestion.todayQuestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todayQuestion.todayQuestionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            todayQuestion.todayQuestionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            todayQuestion.todayQuestionView.heightAnchor.constraint(equalToConstant: 160),
        ])
        todayQuestion.configureAddSubViewsTodayQuestionView()
        todayQuestion.configureConstraintsTodayQuestionView()
    }
}
