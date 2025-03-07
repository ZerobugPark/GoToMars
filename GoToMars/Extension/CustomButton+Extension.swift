//
//  CustomButton+Extension.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//


import UIKit


extension CustomButton {
    
    func buttonConfiguration(title: String, color: UIColor, imageStatus: Bool, imageName: String) -> UIButton.Configuration {
        var configuration = UIButton.Configuration.plain()
                
        var titleContainer = AttributeContainer()
        titleContainer.font = .boldSystemFont(ofSize: 9)
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
    
        configuration.baseForegroundColor = color  // 텍스트 컬러
        configuration.baseBackgroundColor = .clear // 배경 컬러
        
        
        if imageStatus {
            let imageConfig = UIImage.SymbolConfiguration(pointSize: 9, weight: .bold)
            configuration.image = UIImage(systemName: imageName, withConfiguration: imageConfig)
            configuration.imagePadding = 3
        } else {
            let imageConfig = UIImage()
            configuration.image = imageConfig
        }
        
        configuration.buttonSize = .small
      
        return configuration
    }
    
}
