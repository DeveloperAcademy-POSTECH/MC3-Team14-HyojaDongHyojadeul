//
//  ContactState.swift
//  AMaDda
//
//  Created by sanghyo on 2022/08/08.
//

import Foundation
import UIKit

enum ContactState {
    case low(image: UIImage?)
    case middle(image: UIImage?)
    case high(count: Int, image: UIImage?)
    
    var feedBackTitle: String {
        switch self {
        case .low:
            return "애정 뿜뿜!"
        case .middle:
            return "축하드려요!"
        case .high:
            return "엄청나요!"
        }
    }
    
    var feedBackSubTitle: String {
        switch self {
        case .low:
            return "주간 목표를 향해 열심히\n달려가는 중이에요! "
        case .middle:
            return "계획했던 주간 연락 목표를\n달성했어요!"
        case let .high(count, _):
            return "이번주에 \(count)일\n연락했어요!"
        }
    }
    
    var feedBackImage: UIImage? {
        switch self {
        case let .low(image), let .middle(image), let .high(_, image):
            return image
        }
    }
}
