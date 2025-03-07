//
//  CustomButton.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//

import UIKit


final class CustomButton: UIButton {
    
    
    init() {
        super.init(frame: .zero)

    }
    
    convenience init(title: String) {
        self.init()
        configuration = .basicButtonStyle(title: title)
   
    }
    

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
}

//@available (iOS 15.0, *)
extension CustomButton.Configuration {
    
    static func basicButtonStyle(title: String) -> UIButton.Configuration {
       
        var configuration = UIButton.Configuration.plain()
        configuration.title = title
        
        
        var titleContainer = AttributeContainer()
        titleContainer.font = .boldSystemFont(ofSize: 9)

        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        
        configuration.baseForegroundColor = .projectNavy  // 텍스트 컬러
        configuration.baseBackgroundColor = .clear // 배경 컬러
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 9, weight: .bold)
        configuration.image = UIImage(systemName: "arrowtriangle.up.fill", withConfiguration: imageConfig)
        configuration.imagePadding = 3
        
        configuration.buttonSize = .small
      
        return configuration
    }
}
