//
//  NSObject+Extension.swift
//  AMaDda
//
//  Created by 이성민 on 2022/07/19.
//

import UIKit

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
