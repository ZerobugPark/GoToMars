//
//  NFTInfoCollectionViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit

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
            make.centerX.equalToSuperview()
            make.size.equalTo(72)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(4)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview()
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(subTitleLabel.snp.bottom)
            make.horizontalEdges.equalToSuperview()
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
        
        
        let rating = data.pricePercent.roundToPlaces(places: 2)
        
        
        var imageName = ""
        var imageStatus = false
        var title = ""
        var color: UIColor
        
    
        if rating > 0.0 {
            imageName = "arrowtriangle.up.fill"
            imageStatus = true
            title = rating.formatted() + "%"
            color = .projectRed
            
        } else if rating < 0.0 {
            imageName = "arrowtriangle.down.fill"
            imageStatus = true
            title = rating.formatted() + "%"
            color = .projectBlue
            
        } else {
            imageName = ""
            imageStatus = true
            title = rating.formatted() + "%"
            color = .projectNavy
            
        }
        
        statusButton.configuration = statusButton.buttonConfiguration(title: title, color: color, imageStatus: imageStatus, imageName: imageName)
        
        
     
        
        
        
    }
    
    
}

