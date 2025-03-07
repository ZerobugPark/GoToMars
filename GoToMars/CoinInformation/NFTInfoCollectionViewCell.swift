//
//  NFTInfoCollectionViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit

class NFTInfoCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "NFTInfoCollectionViewCell"
    
    
    
    
    private let imageView = UIImageView()
    private let titleLabel = CustomLabel(bold: true, fontSize: 9, color: .projectNavy)
    private let subTitleLabel = CustomLabel(bold: false, fontSize: 9, color: .projectGray)
    
    //static let stackView = UIStackView()
    
    override func configureHierarchy() {
        
        [imageView, titleLabel, subTitleLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.centerX.equalToSuperview()
            make.size.equalTo(72)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
        }
        
        
    }
    
    override func configureView() {
        
        
        imageView.layer.cornerRadius = 10
        imageView.layer.borderWidth = 0
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star")
        
 
        titleLabel.text = "dsada"
        subTitleLabel.text = "xptmxm"
        
    }
    
}
