//
//  UIView+Extension.swift
//  AMaDda
//
//  Created by sanghyo on 2022/07/18.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        for view in views {
            addSubview(view)
        }
    }
}
