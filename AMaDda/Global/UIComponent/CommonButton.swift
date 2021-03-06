//
//  CommonButton.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/17.
//

import UIKit

class CommonButton: UIButton {
    
    private enum Size {
        static let spacing: CGFloat = 20.0
        static let width: CGFloat = UIScreen.main.bounds.width - spacing*2
        static let height: CGFloat = 55.0
    }
    
    // MARK: - property
    
    var title: String? {
        didSet {
            if let title = title {
                setTitle(title, for: .normal)
            }
        }
    }
    
    // MARK: - init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        render()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - func
    
    private func render() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.widthAnchor.constraint(equalToConstant: Size.width).isActive = true
        self.heightAnchor.constraint(equalToConstant: Size.height).isActive = true
    }
    
    private func configureUI() {
        layer.cornerRadius = 10
        titleLabel?.font = UIFont.systemFont(ofSize: 20)
        backgroundColor = .black
    }
}
