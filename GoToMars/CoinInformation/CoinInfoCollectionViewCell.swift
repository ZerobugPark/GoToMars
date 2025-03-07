//
//  CoinInfoCollectionViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit
import SnapKit

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
        contentView.backgroundColor = .systemGreen
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
        
        
        DispatchQueue.main.async {
            self.imageView.layer.cornerRadius = self.imageView.frame.width / 2
        }
        
        imageView.layer.borderWidth = 0
        imageView.clipsToBounds = true
        imageView.image = UIImage(systemName: "star")
        
        numberLabel.text = "1"
        titleLabel.text = "dsada"
        subTitleLabel.text = "xptmxm"
        
    }
    
}
