//
//  NavigationTitleView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit

final class NavigationTitleView: BaseView {
    
    let title = CustomLabel(color: .projectNavy)

    
    override func configureHierarchy() {
        
        self.addSubview(title)
        
 
    }
    
    override func configureLayout() {

        
        title.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(20)
        }
        
        
    }
    
    override func configureView() {
        
        
        
        
        
    }
    
    deinit {
        print("NavigationTitleView Deinit")
    }
}
