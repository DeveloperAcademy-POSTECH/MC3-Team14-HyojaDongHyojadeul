//
//  ProfileModalViewController.swift
//  AMaDda
//
//  Created by sanghyo on 2022/07/17.
//

import UIKit
import SwiftUI

final class ProfileModalViewController: UIViewController {
    
    // MARK: - Properties
    enum Size {
        static let horizontalInset: CGFloat = 20.0
        static let collectionInterItemSize: CGFloat = 5.0
    }
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProfileModalCell.self, forCellWithReuseIdentifier: ProfileModalCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: 0, left: Size.horizontalInset, bottom: 0, right: Size.horizontalInset)
        collectionView.dataSource = self
        collectionView.delegate = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureAddSubviews()
        configureConstraints()
    }
    
    // MARK: - configure
    private func configureUI() {
        view.backgroundColor = .systemBackground
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
}

// MARK: - UICollectionViewDatasource
extension ProfileModalViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //TODO: 이미지 이름 배열에 따른 개수 출력
        return 9
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProfileModalCell.identifier, for: indexPath) as? ProfileModalCell else { fatalError() }
        cell.backgroundColor = .green
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
struct ProfileView: PreviewProvider {
    static var previews: some View {
        ProfileModalViewController().toPreview()
    }
}

