//
//  MainViewController.swift
//  AMaDda
//
//  Created by Lee Myeonghwan & 이성민 on 2022/07/18.
//

import UIKit
import CallKit

final class MainViewController: UIViewController {
    
    let callObserver = CXCallObserver()
    let settingGoalViewController = SettingGoalViewController()
    
    private var member: FamilyMemberData?
    private var familyMembers: [FamilyMemberData] = UserDefaults.standard.familyMembers
    private let todayQuestion = TodayQuestionData.questions
    private lazy var familyMemberCount = familyMembers.count
    private let todayQuestionView = TodayQuestionView()
    private let todayQuestionIndex = UserDefaults.standard.questionIndex
    
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
    private let settingButton: UIBarButtonItem = {
        let image = UIImage.load(systemName: "gearshape")
        let button = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        return button
    }()
    private let feedBackView: FeedBackPopUpView = {
        let view = FeedBackPopUpView()
        view.backgroundColor = .systemBackground
        return view
    }()
    private let blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.alpha = 0
        return blurView
    }()
    
    // MARK: - init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubViews()
        configureConstraints()
        setUpDelegate()
        changeTodayQuestion(todayQuestionIndex)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        familyMembers = UserDefaults.standard.familyMembers
        familyMemberCount = familyMembers.count
        familyTableView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    // MARK: - Selector
    @objc private func tapAddButton() {
        let addingViewController = AddingViewController()
        navigationController?.pushViewController(addingViewController, animated: true)
    }
    
    // MARK: - functions
    
    private func setUpDelegate() {
        settingGoalViewController.delegate = self
        UserDefaultsStateManager.todayQuestionDelegate = self
        familyTableView.delegate = self
        familyTableView.dataSource = self
        feedBackView.delegate = self
        callObserver.setDelegate(self, queue: nil)
    }
    
    private func setButtonMenu() {
        let notiSetting = UIAction(title: "알림 허용 설정", image: ImageLiterals.icBell) { _ in
            guard let url = URL(string: UIApplication.openSettingsURLString) else { return }
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        }
        let cycleSetting = UIAction(title: "알림 주기 설정", image: ImageLiterals.icCalendar) { [weak self] _ in
            guard let self = self else { return }
            let notiSettingViewController = OnboardingTwoViewController()
            notiSettingViewController.cycleViewMode = .setting
            self.navigationController?.pushViewController(notiSettingViewController, animated: true)
        }
        let goalSetting = UIAction(title: "알림 목표 설정", image: ImageLiterals.icPencil) { [weak self] _ in
            guard let self = self else { return }
            //self.notiGoalViewController.cycleViewModeForGoal = .setting
            self.navigationController?.pushViewController(self.settingGoalViewController, animated: true)
        }
        settingButton.menu = UIMenu(options: .displayInline , children: [notiSetting, cycleSetting, goalSetting])
    }
    
    private func makeCall(familyMember: FamilyMemberData) {
        if let phoneCallURL = URL(string: "tel://\(familyMember.contactNumber)") {
            let application: UIApplication = UIApplication.shared
            if (application.canOpenURL(phoneCallURL)) {
                application.open(phoneCallURL, options: [:], completionHandler: nil)
            }
        }
    }
    
    private func updateLastCall(familyMember: FamilyMemberData) {
        var member = familyMember
        member.updateLastContactDate()
        familyMembers = UserDefaults.standard.familyMembers
        DispatchQueue.main.async {
            self.familyTableView.reloadData()
        }
    }
    
    private func showPopUp() {
        view.addSubview(feedBackView)
        feedBackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            feedBackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            feedBackView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            feedBackView.widthAnchor.constraint(equalToConstant: 310),
            feedBackView.heightAnchor.constraint(equalToConstant: 530),
        ])
        feedBackView.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 1
            self.feedBackView.alpha = 1
        }
        self.navigationItem.rightBarButtonItem = nil
        NotificationCenter.default.post(name: NSNotification.Name("showPopUp"), object: UserDefaults.standard.contactGoalCount)
    }
}

extension MainViewController {
    
    // MARK: - configure
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        familyTableView.backgroundColor = .systemBackground
        setButtonMenu()
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.navigationItem.rightBarButtonItem = settingButton
    }
    private func configureAddSubViews() {
        view.addSubviews(todayQuestionView,
                         familyTableLabel,
                         familyTableView,
                        addMemberButton,
                         blurEffectView)
        todayQuestionView.configureAddSubViewsTodayQuestionView()
    }
    private func configureConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        
        todayQuestionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            todayQuestionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            todayQuestionView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: Size.leadingTrailingPadding),
            todayQuestionView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -Size.leadingTrailingPadding),
            todayQuestionView.heightAnchor.constraint(equalToConstant: 140),
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
            familyTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            familyTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            familyTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
        ])
        
        addMemberButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            addMemberButton.centerYAnchor.constraint(equalTo: familyTableLabel.centerYAnchor),
            addMemberButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            addMemberButton.heightAnchor.constraint(equalToConstant: touchAreaSize),
            addMemberButton.widthAnchor.constraint(equalToConstant: touchAreaSize),
        ])
        
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            blurEffectView.topAnchor.constraint(equalTo: view.topAnchor),
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            blurEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
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
        if familyMemberCount != 0 {
            tableView.deselectRow(at: indexPath, animated: true)
            let familyMember = familyMembers[indexPath.row]
            let EditVC = EdittingViewController()
            EditVC.familyMember = familyMember
            navigationController?.pushViewController(EditVC, animated: true)
        }
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch familyMemberCount {
        case 0:
            tableView.separatorStyle = .none
            return 1
        default:
            tableView.separatorStyle = .singleLine
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
            cell.delegate = self
            return cell
        }
    }
}

extension MainViewController: MainSettingGoalDelegate {
    func changeGoal() {
        feedBackView.progressView.updateProgressValues(contactGoalCount: UserDefaults.standard.contactGoalCount)
    }
}

extension MainViewController: TodayQuestionDelegate {
    func changeTodayQuestion(_ index: Int) {
        guard let todayQuestion = todayQuestion[safe: index] else { return }
        DispatchQueue.main.async {
            self.todayQuestionView.todayCardQuestionLabel.text = todayQuestion.question
        }
    }
}

extension MainViewController: FeedBackPopUpViewDelegate {
    func removePopup() {
        UIView.animate(withDuration: 0.3) {
            self.blurEffectView.alpha = 0
            self.feedBackView.alpha = 0
        }
        self.navigationItem.rightBarButtonItem = settingButton
        navigationController?.navigationItem.rightBarButtonItem = settingButton
    }
}

extension MainViewController: FamilyTableCellDelegate {
    
    // MARK: - TableViewCellDelegate
    
    func displayActionSheet(familyMember: FamilyMemberData) {
        member = familyMember
        
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "전화하기", style: .default, handler: { _ in
            self.makeCall(familyMember: familyMember)
        }))
        alert.addAction(UIAlertAction(title: "이미 연락했어요", style: .default, handler: { _ in
            self.updateLastCall(familyMember: familyMember)
            UserDefaultsStateManager().userContacted()
            self.feedBackView.updateCardContent(contactGoalCount: UserDefaults.standard.contactGoalCount, goalCount: UserDefaults.standard.userContactGoal)
            self.showPopUp()
        }))
        alert.addAction(UIAlertAction(title: "취소", style: .cancel, handler:{ _ in

        }))
        
        self.present(alert, animated: true, completion: nil)
    }
}

extension MainViewController: CXCallObserverDelegate {
    
    // MARK: - CXCallObserverDelegate
    
    func callObserver(_ callObserver: CXCallObserver, callChanged call: CXCall) {
        if call.hasConnected == true && call.hasEnded == false {
            guard let member = member else { return }
            updateLastCall(familyMember: member)
            UserDefaultsStateManager().userContacted()
            feedBackView.updateCardContent(contactGoalCount: UserDefaults.standard.contactGoalCount, goalCount: UserDefaults.standard.userContactGoal)
            showPopUp()
        }
    }
}
