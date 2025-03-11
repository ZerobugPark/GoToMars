//
//  NavigationTitleView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit
import SnapKit

final class NavigationTitleView: BaseView {
    
    let titleLabel = CustomLabel(bold: true, fontSize: 16, color: .projectNavy)
        
    override func configureHierarchy() {
        
        self.addSubview(titleLabel)
        
 
    }
    
    override func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview()
        }
        
        
    }
    
    
    deinit {
        print("NavigationTitleView Deinit")
    }
}
