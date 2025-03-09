//
//  NavigationTitleWithImage.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit
import SnapKit

final class NavigationTitleWithImage: BaseView {

    
    
   
    let imageView = UIImageView()
    let titleLabel = CustomLabel(bold: true, fontSize: 16, color: .projectNavy)

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    
    override func configureHierarchy() {
        
        self.addSubview(imageView)
        self.addSubview(titleLabel)

    }
    
    override func configureLayout() {
   
        
        imageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview().offset(-24)
            make.centerY.equalToSuperview()
            make.size.equalTo(24)
        }
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(imageView.snp.trailing).offset(8)
        }
        
        

    }
    
    override func configureView() {
        imageView.clipsToBounds = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.layer.cornerRadius = self.imageView.frame.width / 2
    }
    
    

    
    deinit {
        print("NavigationTitleWithImage Deinit")
    }
}
