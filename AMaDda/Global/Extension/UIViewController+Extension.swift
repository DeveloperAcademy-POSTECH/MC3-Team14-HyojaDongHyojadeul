//
//  UIViewController+Extension.swift
//  AMaDda
//
//  Created by sanghyo on 2022/07/19.
//

import Foundation
import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
            let profileViewController: UIViewController

            func makeUIViewController(context: Context) -> UIViewController {
                return profileViewController
            }

            func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
            }
        }

        func toPreview() -> some View {
            Preview(profileViewController: self)
        }
}
#endif

extension UIViewController {
    func hidekeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
