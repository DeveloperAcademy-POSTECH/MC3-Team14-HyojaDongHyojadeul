//
//  ImageLiteral.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/18.
//

import UIKit

enum ImageLiterals {
    
    // MARK: - icon
    static var icPlus: UIImage { .load(systemName: "plus") }
    static var icSetting: UIImage { .load(systemName: "ellipsis.circle") }
    
    // MARK: - button
    static var btnProfile: UIImage { .load(systemName: "person.circle.fill") }
}

// MARK: - ProfileImage

enum ProfileImage: Int, CaseIterable {
    case normalCat = 1
    case ribbonCat, brownCat, hatCat, noseCat, bellCat, eyebrowCat, necktieCat
    
    static let baseName = "Character"
}
