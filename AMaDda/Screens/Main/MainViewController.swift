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
    private var questionLabel: UILabel = {
        let label = UILabel()
        label.text = "Q.오늘 가족들이 먹은 점심은 무엇인가요?"
        label.font = .systemFont(ofSize: 18)
        return label
    }()
    private lazy var questionView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray
        view.addSubview(questionLabel)
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
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .gray
        return tableView
    }()
    // MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        render()
    }
    // MARK: - Configure
    private func configureUI() {
        view.backgroundColor = .systemBackground
    }
    
    private func render() {
        view.addSubview(mainTitle)
        mainTitle.translatesAutoresizingMaskIntoConstraints = false
        mainTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 45).isActive = true
        mainTitle.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: padding).isActive = true
        
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
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: subTitle.bottomAnchor, constant: 20).isActive = true
        tableView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    // MARK: - Function
    
    // MARK: - Selectors
}

// MARK: - extensions

extension MainViewController: UITableViewDelegate {
    
}

extension MainViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(indexPath.row)"
        return cell
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}
