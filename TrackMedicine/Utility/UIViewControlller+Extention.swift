//
//  UIViewControlller+Extention.swift
//  TrackMedicine
//
//  Created by Hrishikesh Pol on 3/10/21.
//

import UIKit
import Foundation
extension UIViewController {
    func showAlertWithTitle(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                debugPrint("default")
            case .cancel:
                debugPrint("cancel")
            case .destructive:
                debugPrint("destructive")
            @unknown default:
                debugPrint("error")
            }
        }))
        self.present(alert, animated: true, completion: nil)
    }
}
