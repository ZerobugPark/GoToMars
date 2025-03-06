//
//  CustomLabel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit


final class CustomLabel: UILabel {
    
    
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(color: UIColor) {
        self.init()
        
        textColor = color
        font = .boldSystemFont(ofSize: 14)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

