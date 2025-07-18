//
//  CoinInfoCollectionViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit
import SnapKit
import Kingfisher

final class CoinInfoCollectionViewCell: BaseCollectionViewCell {
    
    static let id = "CoinInfoCollectionViewCell"
    
    private let numberLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    private let imageView = UIImageView()
    private let titleLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    private let subTitleLabel = CustomLabel(bold: false, fontSize: 9, color: .projectGray)
    private let statusButton =  CustomButton()
    
    override func configureHierarchy() {
        
        [numberLabel, imageView, titleLabel, subTitleLabel, statusButton].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    override func configureLayout() {
        
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.width.equalTo(15)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(numberLabel.snp.trailing).offset(4)
            make.size.equalTo(26)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(-6)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview().offset(6)
            make.leading.equalTo(imageView.snp.trailing).offset(4)
        }
        
        statusButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-8)
        }
        
        
    }
    
    override func configureView() {
        imageView.layer.borderWidth = 0
        imageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard contentView.bounds.width > 0 else { return }
        
        imageView.layer.cornerRadius = imageView.frame.width / 2
        
    }
    
    
    
    func setup(data: TrendingCoinItem, index: Int) {
        
        numberLabel.text = "\(index + 1)"
        titleLabel.text = data.item.symbol
        subTitleLabel.text = data.item.name
        
        
        if let url = URL(string: data.item.thumb) {
            imageView.kf.setImage(with: url)
        } else {
            imageView.image = UIImage(systemName: "star")
        }
        

        var imageName = ""
        var imageStatus = false
        var title = ""
        var color: UIColor
        
        let status = data.item.data.krwPrice > 0.0 ? true : false
        let rating = data.item.data.krwPrice.roundToPlaces(places: 2)
        
        
        
        if data.item.data.krwPrice == 0.0 {
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

        
        contentView.layoutIfNeeded()
        
    }
    
}
