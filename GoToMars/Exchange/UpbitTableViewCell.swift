//
//  UpbitTableViewCell.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit
import SnapKit

final class UpbitTableViewCell: UITableViewCell {

    static let id = "UpbitTableViewCell"
    
    private let lmarginView = UIView()
    private let rmarginView = UIView()
    private let coinTitleLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    private let currentPriceLabel = CustomLabel(bold: false, fontSize: 12, color: .projectNavy)
    private let ratingLabel = CustomLabel(bold: false, fontSize: 12, color: .projectNavy)
    private let changePriceLabel = CustomLabel(bold: false, fontSize: 9, color: .projectNavy)
    private let accTradeLabel = CustomLabel(bold: false, fontSize: 12, color: .projectNavy)
    
    
    
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
        
        [lmarginView, coinTitleLabel, currentPriceLabel, ratingLabel, changePriceLabel, accTradeLabel, rmarginView].forEach {
            contentView.addSubview($0)
        }
        
        
        
    }
    
    private func configureLayout() {
    
        lmarginView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.safeAreaLayoutGuide)
            make.width.equalToSuperview().multipliedBy(0.04)
            make.height.equalTo(40)
        }
        
        
        coinTitleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(lmarginView.snp.trailing)
            make.width.equalToSuperview().multipliedBy(0.22)
            
        }
     
        currentPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(coinTitleLabel.snp.trailing)
            make.width.equalToSuperview().multipliedBy(0.24)
        }
        
        ratingLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(currentPriceLabel.snp.trailing)
            make.width.equalToSuperview().multipliedBy(0.18)
        }
        
        changePriceLabel.snp.makeConstraints { make in
            make.top.equalTo(ratingLabel.snp.bottom).offset(2)
            make.leading.equalTo(currentPriceLabel.snp.trailing)
            make.width.equalToSuperview().multipliedBy(0.18)
        }
        
        accTradeLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(8)
            make.leading.equalTo(ratingLabel.snp.trailing)
            make.width.equalToSuperview().multipliedBy(0.28)
        }
        
        rmarginView.snp.makeConstraints { make in
            make.top.equalTo(contentView.safeAreaLayoutGuide)
            make.leading.equalTo(contentView.snp.trailing)
            make.width.equalToSuperview().multipliedBy(0.04)
            make.height.equalTo(40)
        }
        
    }
    
    private func configureView() {

        lmarginView.backgroundColor = .white
        rmarginView.backgroundColor = .white
        
        currentPriceLabel.textAlignment = .right
        ratingLabel.textAlignment = .right
        changePriceLabel.textAlignment = .right
        accTradeLabel.textAlignment = .right
        

        
    }
    
    
    func setup(data: UpBitAPI) {
        
        
        coinTitleLabel.text = data.market
        
        
        
        currentPriceLabel.text = data.trade.roundToPlaces(places: 2).formatted()
        
        let num = Int(data.accTrade)
        
        accTradeLabel.text = num >= 1_000_000 ? (num / 1_000_000).formatted() + "백만" : num.formatted()
        
        if data.change == "EVEN" {
            ratingLabel.textColor = .projectNavy
            changePriceLabel.textColor = .projectNavy
        } else if data.change == "RISE" {
            ratingLabel.textColor = .projectRed
            changePriceLabel.textColor = .projectRed
        } else {
            ratingLabel.textColor = .projectBlue
            changePriceLabel.textColor = .projectBlue
        }
        
        ratingLabel.text = data.changeRate.roundToPlaces(places: 2).formatted() + "%"
        changePriceLabel.text = data.changePrice.roundToPlaces(places: 2).formatted()
        
    }
    
    

}



