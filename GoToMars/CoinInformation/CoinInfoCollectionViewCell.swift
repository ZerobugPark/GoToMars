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
    
    let numberLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    private let imageView = UIImageView()
    private let titleLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    private let subTitleLabel = CustomLabel(bold: false, fontSize: 9, color: .projectGray)
    
    
    override func configureHierarchy() {
        
        [numberLabel, imageView, titleLabel, subTitleLabel].forEach {
            contentView.addSubview($0)
        }

    }
    
    override func configureLayout() {
        
        numberLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.width.equalTo(15)
        }
        
        imageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(numberLabel.snp.trailing).offset(8)
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
        
        
    }
    
    override func configureView() {
        imageView.layer.borderWidth = 0
        imageView.clipsToBounds = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard contentView.bounds.width > 0 else { return }
        
        imageView.layer.cornerRadius = self.imageView.frame.width / 2
    
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
        
        contentView.layoutIfNeeded()
        
        
    }
    
}
