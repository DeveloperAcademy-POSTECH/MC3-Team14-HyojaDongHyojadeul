//
//  NSObject+Extension.swift
//  AMaDda
//
//  Created by 이성호 on 2022/07/17.
//

import Foundation

extension NSObject {
    static var className: String {
        return String(describing: self)
    }
}
