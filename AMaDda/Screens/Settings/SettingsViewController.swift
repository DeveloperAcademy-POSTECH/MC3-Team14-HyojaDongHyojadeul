//
//  SettingsViewController.swift
//  AMaDda
//
//  Created by Seik Oh on 2022/07/20.
//

import UIKit

private let reusableIdentifier = "cell"

class SettingsViewController: UITableViewController {
    // MARK: - properties
    let items = ["알림 허용 설정", "알림 주기 설정"]
    
    // MARK: - life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDelegate()
        configureUI()
    }
    
    // MARK: - configure
    private func configureUI() {
        view.backgroundColor = .SettingsViewBackgroundColor
        navigationController?.navigationBar.isHidden = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: reusableIdentifier)
    }
    
    // MARK: - function
    private func setUpDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableIdentifier, for: indexPath)
        var content = cell.defaultContentConfiguration()
        content.text = self.items[indexPath.row]
        content.textProperties.font = UIFont.systemFont(ofSize: 20)
        cell.contentConfiguration = content
        return cell
    }
}
