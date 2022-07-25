//
//  Collection+Extension.swift
//  AMaDda
//
//  Created by Lee Myeonghwan on 2022/07/25.
//

import Foundation

extension Collection {
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
