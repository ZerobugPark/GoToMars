//
//  DetailInfoView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/9/25.
//

import UIKit
import SnapKit

final class DetailInfoView: BaseView {

    
    let mainStackView = UIStackView()

    private let topView = UIView()
    private let middleView = UIView()
 
    
    
    let titleLabel = CustomLabel(bold: true, fontSize: 14, color: .projectNavy)
    let moreButton =  CustomButton(buttonImage: "chevron.right", imagePlacement: .trailing)
    
    
    // 24시간 고가
    let priceTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let priceLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    
    // 24시간 저가
    let lowPriceTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let lowPriceLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    
    
    // 역대 최고가
    let athPriceTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let athPriceLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    let athDateLabel = CustomLabel(bold: false, fontSize: 9, color: .projectGray)
    
    
    // 역대 최저가
    let atlPriceTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let atlPriceLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    let atlDateLabel = CustomLabel(bold: false, fontSize: 9, color: .projectGray)
    

    override func configureHierarchy() {
        
        self.addSubview(titleLabel)
        self.addSubview(moreButton)
        self.addSubview(mainStackView)

        
        [topView, middleView].forEach {
            mainStackView.addArrangedSubview($0)
        }

        [priceTitleLabel, priceLabel, lowPriceTitleLabel, lowPriceLabel].forEach {
            topView.addSubview($0)
        }
        
        [athPriceTitleLabel, athPriceLabel, athDateLabel, atlPriceTitleLabel, atlPriceLabel, atlDateLabel].forEach {
            middleView.addSubview($0)
        }
        

        
        
 
    }
    
    override func configureLayout() {
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.leading.equalToSuperview().offset(16)
        }
        
        moreButton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.trailing.equalToSuperview().offset(-8)
        }
     
        mainStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
            make.horizontalEdges.equalToSuperview().inset(16)
            
        }
        
        // MARK: - 24시간 고/저가 or 시가 총액
        topView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(55)
        }
        
        priceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(topView.snp.leading).offset(16)

        }
       
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(priceTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(topView.snp.leading).offset(16)
      
        }
        
    
        lowPriceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(topView.snp.centerX).offset(16)
        }
        
    
        lowPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(lowPriceTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(topView.snp.centerX).offset(16)
           
       
        }
        
        
        // MARK: - 역대 최고/저가 or 완전 희석 가치
        middleView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(70)
        }
        
        athPriceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(middleView.snp.leading).offset(16)

        }
                
        athPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(athPriceTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(middleView.snp.leading).offset(16)
           
        }
        
        
        athDateLabel.snp.makeConstraints { make in
            make.top.equalTo(athPriceLabel.snp.bottom).offset(4)
            make.leading.equalTo(middleView.snp.leading).offset(16)
       
        }
        

        atlPriceTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(middleView.snp.centerX).offset(16)
        }

        
        atlPriceLabel.snp.makeConstraints { make in
            make.top.equalTo(atlPriceTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(middleView.snp.centerX).offset(16)
           
        }
        
       
        atlDateLabel.snp.makeConstraints { make in
            make.top.equalTo(atlPriceLabel.snp.bottom).offset(4)
            make.leading.equalTo(middleView.snp.centerX).offset(16)
       
        }

        
    }
    
    override func configureView() {
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.layer.cornerRadius = 10
        mainStackView.clipsToBounds = true
        mainStackView.backgroundColor = .projectLightGray
        
        mainStackView.spacing = 0

    }
    
    deinit {
        print("DetailInfoView Deinit")
    }
    
    
}
