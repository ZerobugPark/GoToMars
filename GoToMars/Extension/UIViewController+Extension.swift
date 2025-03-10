//
//  UIViewController+Extension.swift
//  GoToMars
//
//  Created by youngkyun park on 3/11/25.
//

import UIKit


extension UIViewController {
    
    func showAlert(msg: String) {
        
        let title = "안내"
        let alert = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default)
        alert.addAction(ok)
        
        present(alert, animated: true)
        
        
    }
    
}
