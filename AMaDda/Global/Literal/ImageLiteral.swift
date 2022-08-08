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
    static var catSole: UIImage { .load(name: "CatSole")}
    // MARK: - design
    static var openingQuote: UIImage { .load(systemName: "quote.opening")}
    static var closingQuote: UIImage { .load(systemName: "quote.closing")}
    static var FeedBackHigh1: UIImage { .load(name: "FeedBackHigh1") }
    static var FeedBackHigh2: UIImage { .load(name: "FeedBackHigh2") }
    static var FeedBackHigh3: UIImage { .load(name: "FeedBackHigh3") }
    
    static var FeedBackLow1: UIImage { .load(name: "FeedBackLow1") }
    static var FeedBackLow2: UIImage { .load(name: "FeedBackLow2") }
    static var FeedBackMiddle1: UIImage { .load(name: "FeedBackMiddle1") }
    static var FeedBackMiddle2: UIImage { .load(name: "FeedBackMiddle2") }
    static var FeedBackMiddle3: UIImage { .load(name: "FeedBackMiddle3") }
}

// MARK: - ProfileImage

enum ProfileImage: Int, CaseIterable {
    case normalCat = 1
    case ribbonCat, brownCat, hatCat, noseCat, bellCat, eyebrowCat, bowtieCat, necktieCat, scarCat, glassesTie
    
    static let baseName = "Character"
}
