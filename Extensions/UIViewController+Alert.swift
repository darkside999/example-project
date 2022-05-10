//
//  UIViewController+Alert.swift
//  Trips
//
//  Created by Indir Amerkhanov on 20.04.2022.
//

import UIKit

extension UIViewController {
    func showAlert(
        message: String,
        title: String = "",
        okTitle: String = "OK",
        okAction: @escaping () -> Void = { },
        secondButtonTitle: String? = nil,
        secondAction: @escaping () -> Void = { }
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: okTitle, style: .default, handler: { _ in okAction() })
        alertController.addAction(okAction)

        if let secondButtonTitle = secondButtonTitle {
            let secondAction = UIAlertAction(title: secondButtonTitle, style: .default, handler: { _ in secondAction() } )
            alertController.addAction(secondAction)
        }

        self.present(alertController, animated: true, completion: nil)
    }
}
