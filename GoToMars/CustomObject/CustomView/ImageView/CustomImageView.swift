//
//  CustomImageView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit

final class CustomImageView: UIImageView {
    
    init() {
        super.init(frame: .zero)
    }
    
    convenience init(imageName: String) {
        self.init()
        
        image = UIImage(systemName: imageName)
        tintColor = .projectGray
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
