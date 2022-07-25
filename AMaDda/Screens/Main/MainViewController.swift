//
//  MainViewController.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/18.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    //private var familyMembers = FamilyMemberMockData.familyMemberData
    private var familyMembers = Array<FamilyMemberData>() {
        didSet {
            familyMemberCount = familyMembers.count
            familyTableView.reloadData()
        }
    }
    private var familyMemberCount = 0
    private let todayQuestionView = TodayQuestionView()
    
    private let familyTableLabel: UILabel = {
        let label = UILabel()
        label.text = "우리 가족"
        label.font = UIFont.systemFont(ofSize: 28, weight: .bold)
        return label
    }()
    private let familyTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FamilyTableCell.self, forCellReuseIdentifier: FamilyTableCell.className)
        tableView.register(EmptyTableViewCell.self, forCellReuseIdentifier: EmptyTableViewCell.className)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubViews()
        configureConstraints()
        setUpDelegate()
    }
    
    // MARK: - functions
    private func setUpDelegate() {
        familyTableView.delegate = self
        familyTableView.dataSource = self
    }
}

extension MainViewController {
    // MARK: - configure
    private func configureUI() {
        view.backgroundColor = .systemBackground
        familyTableView.backgroundColor = .systemBackground
    }
    private func configureAddSubViews() {
        view.addSubviews(todayQuestionView,
                         familyTableLabel,
                         familyTableView)
        todayQuestionView.configureAddSubViewsTodayQuestionView()
    }
    private func configureConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        todayQuestionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayQuestionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            todayQuestionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            todayQuestionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            todayQuestionView.heightAnchor.constraint(equalToConstant: 160),
        ])
        todayQuestionView.configureConstraintsTodayQuestionView()
        
        familyTableLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyTableLabel.topAnchor.constraint(equalTo: todayQuestionView.bottomAnchor, constant: 35),
            familyTableLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        
        familyTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyTableView.topAnchor.constraint(equalTo: familyTableLabel.bottomAnchor, constant: 20),
            familyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Size.leadingTrailingPadding),
            familyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Size.leadingTrailingPadding),
            familyTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
    }
}

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch familyMemberCount {
        case 0:
            return familyTableView.frame.height
        default:
            return 140
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch familyMemberCount {
        case 0:
            return 1
        default:
            return familyMembers.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch familyMemberCount {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: EmptyTableViewCell.className, for: indexPath) as? EmptyTableViewCell else {
                return UITableViewCell()
            }
            return cell
        default:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FamilyTableCell.className, for: indexPath) as? FamilyTableCell else { fatalError() }
            let item = self.familyMembers[indexPath.row]
            cell.item = item
            cell.selectionStyle = .none
            return cell
        }
    }
}
