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

extension UIViewController: UIGestureRecognizerDelegate {
    func hidekeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tap.delegate = self
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        guard touch.view is UIButton else { return true }
        return false
    }
}
