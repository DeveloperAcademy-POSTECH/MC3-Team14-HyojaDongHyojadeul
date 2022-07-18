//
//  MainViewController.swift
//  AMaDdaTT
//
//  Created by LeeSungHo on 2022/07/15.
//

import UIKit

class MainViewController: UIViewController {
    // MARK: - Property
    private let mainTitle: UILabel = {
        let label = UILabel()
        label.text = "오늘의 가족 Questoin"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    private lazy var settingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("설정", for: .normal)
        button.addTarget(self, action: #selector(didTapSettingButton), for: .touchUpInside)
        return button
    }()
    private var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Q.오늘 가족들이 먹은 점심은 무엇인가요?"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    private lazy var questionView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.questionViewBackgroundColor
        view.addSubview(questionLabel)
        view.layer.cornerRadius = 12
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        questionLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        return view
    }()
    private let subTitle: UILabel = {
        let label = UILabel()
        label.text = "우리 가족"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    private let addingButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        return button
    }()
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(QuestionTableViewCell.self, forCellReuseIdentifier: QuestionTableViewCell.className)
        tableView.backgroundColor = .systemBackground
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupTableView()
        render()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - Configure
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureAddSubView() {
        view.addSubview(mainTitle)
    }
    private func configureConstraints() {
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45),
            mainTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding),
        ])
    }
    
    private func render() {
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        
        view.addSubview(settingButton)
        settingButton.translatesAutoresizingMaskIntoConstraints = false
        settingButton.topAnchor.constraint(equalTo: mainTitle.topAnchor).isActive = true
        settingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding).isActive = true
        
        view.addSubview(questionView)
        questionView.translatesAutoresizingMaskIntoConstraints = false
        questionView.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 35).isActive = true
        questionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        questionView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - padding*2).isActive = true
        questionView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        view.addSubview(subTitle)
        subTitle.translatesAutoresizingMaskIntoConstraints = false
        subTitle.topAnchor.constraint(equalTo: questionView.bottomAnchor, constant: 35).isActive = true
        subTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: padding).isActive = true
        
        view.addSubview(addingButton)
        addingButton.translatesAutoresizingMaskIntoConstraints = false
        addingButton.topAnchor.constraint(equalTo: subTitle.topAnchor).isActive = true
        addingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -padding).isActive = true
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,constant: padding).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,constant: -padding).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Function
    
    // MARK: - Selectors
    @objc private func didTapSettingButton() {
        navigationController?.pushViewController(SettingViewController(), animated: true)
    }
}

// MARK: - extensions

extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: QuestionTableViewCell.className, for: indexPath) as! QuestionTableViewCell
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}
