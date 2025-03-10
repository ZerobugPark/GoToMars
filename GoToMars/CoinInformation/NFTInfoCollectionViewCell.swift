//
//  NFTInfoCollectionViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit
import SnapKit

final class NFTInfoCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "NFTInfoCollectionViewCell"
    
    private let imageView = UIImageView()
    private let titleLabel = CustomLabel(bold: true, fontSize: 9, color: .projectNavy)
    private let subTitleLabel = CustomLabel(bold: false, fontSize: 9, color: .projectGray)
    private let statusButton = CustomButton()
    
    override func configureHierarchy() {
        
        [imageView, titleLabel, subTitleLabel,statusButton].forEach {
            contentView.addSubview($0)
        }
    }
    
    override func configureLayout() {
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.size.equalTo(72)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom)
            make.centerX.equalTo(contentView.safeAreaLayoutGuide)
        }
        
    }
    
    override func configureView() {
        
        
        imageView.layer.cornerRadius = 15
        imageView.layer.borderWidth = 0
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star")
        
        titleLabel.textAlignment = .center
        subTitleLabel.textAlignment = .center
    }
    
    
    
    func setup(data: Nfts) {
        
        
        titleLabel.text = data.symbol
        subTitleLabel.text = data.name
        
        
        if let url = URL(string: data.thumb) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "star")
        }
        
    
        var imageName = ""
        var imageStatus = false
        var title = ""
        var color: UIColor
        

        let status = data.pricePercent > 0.0 ? true : false
        let rating = data.pricePercent.roundToPlaces(places: 2)
        
           
        if data.pricePercent == 0.0 {
            imageName = ""
            imageStatus = true
            title = rating.formatted() + "%"
            color = .projectNavy
            
            
        } else {
            
            if status {
                imageName = "arrowtriangle.up.fill"
                imageStatus = true
                title = rating.formatted() + "%"
                color = .projectRed
            } else {
                imageName = "arrowtriangle.down.fill"
                imageStatus = true
                title = rating.formatted() + "%"
                color = .projectBlue
            }
            
            
        }
        
        statusButton.configuration = statusButton.buttonConfiguration(title: title, color: color, imageStatus: imageStatus, imageName: imageName)
    
    }
    
    
}

