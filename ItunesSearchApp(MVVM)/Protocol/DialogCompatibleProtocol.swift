//
//  DialogCompatibleProtocol.swift
//  ItunesSearchApp(MVVM)
//
//  Created by Emrah Zorlu on 2.04.2024.
//

import Foundation
import UIKit

protocol ErrorDialogProtocol: AnyObject {
    func showErrorDialog(_ message: String)
}

protocol InformationDialogProtocol: AnyObject {
    func showSuccessDialog(_ message: String)
}

protocol DialogCompatibleProtocol: ErrorDialogProtocol, InformationDialogProtocol {
    func showInfoPopup(message: String)
}

extension UIViewController: DialogCompatibleProtocol {
    func showInfoPopup(message: String) {
        // show info popup
    }
    
    func showErrorDialog(_ message: String) {
        // show error dialog
    }
    
    func showSuccessDialog(_ message: String) {
        // show success dialog
    }
}
