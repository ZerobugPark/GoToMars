//
//  fillterButtonView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit
import SnapKit

class filterButtonView: BaseView {

    
    let titleLabel = CustomLabel(bold: true, fontSize: 14, color: .projectGray)
    let topImage = CustomImageView(imageName: "arrowtriangle.up.fill")
    let bottomImage = CustomImageView(imageName: "arrowtriangle.down.fill")
    
    override func configureHierarchy() {
        
    
        [titleLabel, topImage, bottomImage].forEach {
            self.addSubview($0)
        }
 
    }
    
    override func configureLayout() {

        
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.height.equalTo(15)
        }
        
        topImage.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(7)
            make.centerY.equalToSuperview().offset(-4)
            make.leading.equalTo(titleLabel.snp.trailing).offset(1)
        }
        
        bottomImage.snp.makeConstraints { make in
            make.height.equalTo(10)
            make.width.equalTo(7)
            make.centerY.equalToSuperview().offset(4)
            make.leading.equalTo(titleLabel.snp.trailing).offset(1)
        }
        
    }
    
    deinit {
        print("filterButtonView Deinit")
    }
}
