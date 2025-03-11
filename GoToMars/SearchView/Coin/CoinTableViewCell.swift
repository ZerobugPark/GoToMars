//
//  CoinTableViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit

import SnapKit
import RxSwift
import Kingfisher


final class CoinTableViewCell: UITableViewCell {

    static let id = "CoinTableViewCell"
    
    private let symbolImageView = UIImageView()
    private let titleLabel = CustomLabel(bold: true, fontSize: 14, color: .projectNavy)
    private let subTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    private let rankLabel = PaddingLabel(bold: true, fontSize: 9, color: .projectGray)
    let likeButton = CustomButton()
    var disposeBag = DisposeBag()
    
    
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
        
        [symbolImageView, titleLabel, subTitleLabel, rankLabel, likeButton].forEach {
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
        
        likeButton.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.trailing.equalTo(contentView.safeAreaLayoutGuide).offset(-16)
        }
      
    }
    
    private func configureView() {
        symbolImageView.layer.borderWidth = 0
        symbolImageView.clipsToBounds = true
        
        likeButton.tintColor = .projectNavy
        rankLabel.backgroundColor = .projectLightGray
        rankLabel.layer.cornerRadius = 5
        rankLabel.clipsToBounds = true
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        disposeBag = DisposeBag()

        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        guard contentView.bounds.width > 0 else { return }
        
        symbolImageView.layer.cornerRadius = symbolImageView.frame.width / 2
    

    }
    
    

    func setup(data: SearchCoin) {
        
        let url = URL(string: data.thumb)
        
        if let url = url {
         
            symbolImageView.kf.setImage(with: url)
        } else {
            symbolImageView.image = UIImage(systemName: "star")
        }
        
        
        titleLabel.text = data.symbol
        subTitleLabel.text = data.name
        
        rankLabel.text = "#\(data.rank)"
        
        likeButton.setImage(UIImage(systemName: "star"), for: .normal)
        
        
        contentView.layoutIfNeeded()
    }

}
