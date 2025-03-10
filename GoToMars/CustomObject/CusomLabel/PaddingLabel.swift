//
//  PaddingLabel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit


final class PaddingLabel: UILabel {
    
    
    private let padding = UIEdgeInsets(top: 2.0, left: 2.0, bottom: 2.0, right: 2.0)
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(bold: Bool, fontSize: CGFloat, color: UIColor) {
        self.init()
        
        font = bold ? .boldSystemFont(ofSize: fontSize) : .systemFont(ofSize: fontSize, weight: .regular)
        textColor = color
    
        
    }
    
    override func drawText(in rect: CGRect) {
        super.drawText(in: rect.inset(by: padding))
    }
    

    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right

        return contentSize
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

}
