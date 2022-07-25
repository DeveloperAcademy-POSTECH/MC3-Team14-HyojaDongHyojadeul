//
//  MainViewController.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/18.
//

import Foundation
import UIKit

final class MainViewController: UIViewController {
    private var familyMembers: [FamilyMemberData] = {
        UserDefaults.standard.familyMembers = FamilyMemberMockData.familyMemberData
//        guard let familyMembers = UserDefaults.standard.familyMembers else {
//            print("아직 추가한 가족 멤버 없음")
//            return nil
//        }
        let familyMembers: [FamilyMemberData] = UserDefaults.standard.familyMembers
        return familyMembers
    }()
    private lazy var familyMemberCount = familyMembers.count
    private let todayQuestionView = TodayQuestionView()
    
    private let touchAreaSize: CGFloat = 44
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
        tableView.showsVerticalScrollIndicator = false
        return tableView
    }()
    private lazy var addMemberButton: UIButton = {
        let button = UIButton()
        let configuration = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage.load(systemName: "plus", configuration: configuration)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(tapAddButton), for: .touchUpInside)
        return button
    }()
    private let settingButton: UIButton = {
        let button = UIButton()
        let configuaration = UIImage.SymbolConfiguration(pointSize: 24)
        let image = UIImage.load(systemName: "ellipsis.circle", configuration: configuaration)
        button.setImage(image, for: .normal)
        button.showsMenuAsPrimaryAction = true
        return button
    }()
    
    // MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubViews()
        configureConstraints()
        setUpDelegate()
    }
    
    // MARK: - Selector
    @objc private func tapAddButton() {
        let addingViewController = AddingViewController()
        navigationController?.pushViewController(addingViewController, animated: true)
    }
    
    // MARK: - functions
    
    private func setUpDelegate() {
        familyTableView.delegate = self
        familyTableView.dataSource = self
    }
    
    private func setButtonMenu() {
        let notiSetting = UIAction(title: "알림 허용 설정", image: ImageLiterals.icBell) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cycleSetting = UIAction(title: "알림 주기 설정", image: ImageLiterals.icPencil) { [weak self] _ in
            let notiSettingViewController = OnboardingTwoViewController()
            let notificationCycle = UserDefaults.standard.userNotificationCycle
            notiSettingViewController.cycleViewMode = .setting(cycle: notificationCycle ?? 3)
            self?.navigationController?.pushViewController(notiSettingViewController, animated: true)
        }
        settingButton.menu = UIMenu(options: .displayInline , children: [notiSetting, cycleSetting])
    }
}

extension MainViewController {
    
    // MARK: - configure
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        familyTableView.backgroundColor = .systemBackground
        setButtonMenu()
    }
    private func configureAddSubViews() {
        view.addSubviews(todayQuestionView,
                         familyTableLabel,
                         familyTableView,
                        addMemberButton,
                        settingButton)
    }
    private func configureConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        todayQuestionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayQuestionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            todayQuestionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            todayQuestionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            todayQuestionView.heightAnchor.constraint(equalToConstant: 170),
        ])
        
        familyTableLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyTableLabel.topAnchor.constraint(equalTo: todayQuestionView.bottomAnchor, constant: 35),
            familyTableLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: Size.leadingTrailingPadding),
        ])
        
        familyTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            familyTableView.topAnchor.constraint(equalTo: familyTableLabel.bottomAnchor, constant: 20),
            familyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            familyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            familyTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
        addMemberButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMemberButton.centerYAnchor.constraint(equalTo: familyTableLabel.centerYAnchor),
            addMemberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Size.leadingTrailingPadding),
            addMemberButton.heightAnchor.constraint(equalToConstant: touchAreaSize),
            addMemberButton.widthAnchor.constraint(equalToConstant: touchAreaSize),
        ])
        
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingButton.centerYAnchor.constraint(equalTo: todayQuestionView.todayTitleLabel.centerYAnchor),
            settingButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -Size.leadingTrailingPadding),
            settingButton.heightAnchor.constraint(equalToConstant: touchAreaSize),
            settingButton.widthAnchor.constraint(equalToConstant: touchAreaSize),
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
            tableView.separatorStyle = .none
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
