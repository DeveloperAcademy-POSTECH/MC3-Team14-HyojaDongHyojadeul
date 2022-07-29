//
//  UIViewController+Extension.swift
//  AMaDda
//
//  Created by sanghyo on 2022/07/19.
//

import Foundation
import SwiftUI

extension UIViewController {
    
    func makeAlert(title: String,
                   message: String,
                   okAction: ((UIAlertAction) -> Void)? = nil,
                   completion : (() -> Void)? = nil) {
        let alertViewController = UIAlertController(title: title,
                                                    message: message,
                                                    preferredStyle: .alert)
        let okAction = UIAlertAction(title: "확인", style: .default, handler: okAction)
        alertViewController.addAction(okAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
    func makeRequestAlert(title: String,
                          message: String,
                          okTitle: String = "삭제",
                          cancelTitle: String = "취소",
                          okAction: ((UIAlertAction) -> Void)?,
                          cancelAction: ((UIAlertAction) -> Void)? = nil,
                          completion : (() -> Void)? = nil) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        let alertViewController = UIAlertController(title: title, message: message,
                                                    preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: okTitle, style: .destructive, handler: okAction)
        alertViewController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: cancelTitle, style: .default, handler: cancelAction)
        alertViewController.addAction(cancelAction)
        
        self.present(alertViewController, animated: true, completion: completion)
    }
    
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
