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
        
    
    convenience init(bold: Bool, fontSize: CGFloat, color: UIColor) {
        self.init()
        
        font = bold ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .regular)
        textColor = color
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

