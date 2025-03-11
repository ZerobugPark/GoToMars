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
    
    convenience init(buttonImage: String, imagePlacement: NSDirectionalRectEdge) {
        self.init()
        let title = "더보기"
        configuration = .imageButtonStyle(title: title, image: buttonImage, imgplacement: imagePlacement)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    
}


extension CustomButton.Configuration {
    
    static func imageButtonStyle(title: String,image: String, imgplacement: NSDirectionalRectEdge) -> UIButton.Configuration {
       
        var configuration = UIButton.Configuration.filled()
        
        var titleContainer = AttributeContainer()
        titleContainer.font = .boldSystemFont(ofSize: 12)
        configuration.attributedTitle = AttributedString(title, attributes: titleContainer)
        
        configuration.baseForegroundColor = .projectGray  // 텍스트 컬러
        configuration.baseBackgroundColor = .clear // 배경 컬러
        
        let imageConfig = UIImage.SymbolConfiguration(pointSize: 9, weight: .bold)
        configuration.image = UIImage(systemName: image, withConfiguration: imageConfig)
        configuration.imagePadding = 0
        configuration.imagePlacement = imgplacement
        
        configuration.buttonSize = .medium
      
        return configuration
    }
}
