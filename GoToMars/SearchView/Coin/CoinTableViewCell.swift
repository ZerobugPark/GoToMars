//
//  CoinTableViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit

final class CoinTableViewCell: UITableViewCell {

    static let id = "CoinTableViewCell"
    
    private let symbolImageView = UIImageView()
    private let titleLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    private let subTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    private let rankLabel = CustomLabel(bold: true, fontSize: 9, color: .projectGray)
    private let starButton = CustomButton()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configureHierarchy() {
        
        [symbolImageView, titleLabel, subTitleLabel, rankLabel, starButton].forEach {
            contentView.addSubview($0)
        }
        
        
    }
    
    private func configureLayout() {
    
        
        symbolImageView.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide).offset(16)
            make.size.equalTo(36)
        }
        
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide).offset(-8)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(4)
        }
        
        subTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(symbolImageView.snp.trailing).offset(4)
        }
        
        rankLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide).offset(-8)
            make.leading.equalTo(titleLabel.snp.trailing).offset(4)
        }
        
        starButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
        }
      
    }
    
    private func configureView() {
        symbolImageView.layer.borderWidth = 0
        symbolImageView.clipsToBounds = true
        
        symbolImageView.image = UIImage(systemName: "star")
        titleLabel.text = "123"
        subTitleLabel.text = "456"
        
        rankLabel.text = "11"
        
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        rankLabel.backgroundColor = .projectLightGray
        rankLabel.layer.cornerRadius = 5
        //rankLabel.clipsToBounds = true
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard contentView.bounds.width > 0 else { return }
        
        symbolImageView.layer.cornerRadius = symbolImageView.frame.width / 2
    

    }
    
    

    func setup() {
        
        symbolImageView.image = UIImage(systemName: "star")
        titleLabel.text = "123"
        subTitleLabel.text = "456"
        
        rankLabel.text = "11"
        
        starButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        
        contentView.layoutIfNeeded()
    }

}
