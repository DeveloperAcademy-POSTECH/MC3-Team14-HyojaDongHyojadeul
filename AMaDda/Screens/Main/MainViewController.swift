//
//  MainViewController.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/17.
//

import UIKit

final class MainViewController: UIViewController {
    private let todayQuestionView = TodayQuestionView()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubViews()
        configureConstraints()
    }
}

extension MainViewController {
    // MARK: - configure
    private func configureUI() {
        guard let view = self.view else { return }
        view.backgroundColor = UIColor.amaddaBackgroundColor
    }
    private func configureAddSubViews() {
        guard let view = self.view else { return }
        view.addSubview(todayQuestionView)
        todayQuestionView.configureAddSubViewsTodayQuestionView()
    }
    private func configureConstraints() {
        todayQuestionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayQuestionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            todayQuestionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            todayQuestionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            todayQuestionView.heightAnchor.constraint(equalToConstant: 160),
        ])
        todayQuestionView.configureConstraintsTodayQuestionView()
    }
}
