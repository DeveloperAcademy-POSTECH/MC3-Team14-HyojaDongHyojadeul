//
//  ProfileModalViewController.swift
//  AMaDda
//
//  Created by sanghyo on 2022/07/17.
//

import UIKit

// TODO: edit, add viewController에서 delegate 구현 필요
protocol profileModalViewDelegate: AnyObject {
    func registerSelectedCharacter(imageName: String)
}

final class ProfileModalViewController: UIViewController {
    // MARK: - Properties
    private enum Size {
        static let horizontalInset: CGFloat = 20.0
        static let collectionInterItemSize: CGFloat = 20.0
    }

    // TODO: 이미지 이름 바인딩 필요
    var selectedCharacterName = "Character1"
    private var postfixNums = Array<Int>(1...8)
    private lazy var characterNames: [String] = {
        let names = postfixNums.map {
            "Character" + String($0)
        }
        return names
    }()
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfileModalCell.self, forCellWithReuseIdentifier: ProfileModalCell.className)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Size.horizontalInset, bottom: 0, right: Size.horizontalInset)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    private lazy var cancelBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(tapBarButton(_:)))
        button.tag = 0
        return button
    }()
    private lazy var registerBarButton: UIBarButtonItem = {
        let button = UIBarButtonItem(title: "등록", style: .plain, target: self, action: #selector(tapBarButton(_:)))
        button.tag = 1
        return button
    }()
    weak var delegate: profileModalViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubviews()
        configureConstraints()
    }
    
    // MARK: - configure
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationItem.leftBarButtonItem = cancelBarButton
        navigationItem.rightBarButtonItem = registerBarButton
    }
    
    private func configureAddSubviews() {
        view.addSubview(collectionView)
    }
    
    private func configureConstraints() {
        let safeAreaLayoutGuide = view.safeAreaLayoutGuide
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 50),
            collectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    // MARK: - Function
    private func getImageIndex(by name: String) -> Int {
        guard let index = characterNames.firstIndex(of: name) else { fatalError() }
        return index
    }
    
    // MARK: - Selector
    @objc func tapBarButton(_ sender: Any) {
        guard let sender = sender as? UIBarButtonItem else { return }
        if sender.tag == 1 {
            // TODO: 데이터 바인딩 방법에 따른 코드 구현
            let imageIndex = getImageIndex(by: selectedCharacterName)
            self.delegate?.registerSelectedCharacter(imageName: characterNames[imageIndex])
        }
        navigationController?.popViewController(animated: true)
    }
}

// MARK: - UICollectionViewDatasource
extension ProfileModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: 이미지 이름 배열에 따른 개수 출력
        return characterNames.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileModalCell.className, for: indexPath) as? ProfileModalCell else { fatalError() }
        let imageIndex = getImageIndex(by: selectedCharacterName)
        if indexPath.row == imageIndex {
            cell.isSelected = true
            collectionView.selectItem(at: indexPath, animated: false, scrollPosition: .init())
        }
        cell.isSelected = indexPath.row == imageIndex
        cell.imageName = characterNames[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return Size.collectionInterItemSize
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension ProfileModalViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (view.frame.width - Size.horizontalInset * 2 - Size.collectionInterItemSize * 2) / 3
        let height = width * 1.5
        return CGSize(width: width, height: height)
    }
}

// MARK: - Preview
#if DEBUG
import SwiftUI

struct ProfileView: PreviewProvider {
    static var previews: some View {
        ProfileModalViewController().toPreview()
    }
}
#endif
