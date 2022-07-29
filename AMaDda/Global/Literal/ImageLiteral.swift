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
    static var icBell: UIImage { .load(systemName: "bell") }
    static var icPencil: UIImage { .load(systemName: "pencil") }
    static var icCalendar: UIImage { .load(systemName: "calendar") }
    
    // MARK: - button
    static var btnProfile: UIImage { .load(systemName: "person.circle.fill") }
    // MARK: - design
    static var openingQuote: UIImage { .load(systemName: "quote.opening")}
    static var closingQuote: UIImage { .load(systemName: "quote.closing")}
}

// MARK: - ProfileImage

enum ProfileImage: Int, CaseIterable {
    case normalCat = 1
    case ribbonCat, brownCat, hatCat, noseCat, bellCat, eyebrowCat, bowtieCat, necktieCat, scarCat, glassesTie
    
    static let baseName = "Character"
}
