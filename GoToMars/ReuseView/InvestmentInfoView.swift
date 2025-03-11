//
//  InvestmentInfoView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/9/25.
//

import UIKit

class InvestmentInfoView: BaseView {
    
    private let mainStackView = UIStackView()

    private let topView = UIView()
    private let middleView = UIView()
    private let bottomView = UIView()
    
    
    let titleLabel = CustomLabel(bold: true, fontSize: 14, color: .projectNavy)
    let moreButton =  CustomButton(buttonImage: "chevron.right", imagePlacement: .trailing)
    
    
    // 24시간 고가 및 시가 총액
    let marketCapTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let marketCapLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)

    
    // 역대 최고가 및 FDV(완전 희석 가치)
    let fdvTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let fdvLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    
    
    // 총거래량
    let totalVolumeTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let totalVolumeLabel = CustomLabel(bold: true, fontSize: 12, color: .projectNavy)
    
    
    override func configureHierarchy() {
        
        self.addSubview(titleLabel)
        self.addSubview(moreButton)
        self.addSubview(mainStackView)

        
        [topView, middleView, bottomView].forEach {
            mainStackView.addArrangedSubview($0)
        }

        [marketCapTitleLabel, marketCapLabel].forEach {
            topView.addSubview($0)
        }
        
        [fdvTitleLabel, fdvLabel].forEach {
            middleView.addSubview($0)
        }
        
        [totalVolumeTitleLabel, totalVolumeLabel].forEach {
            bottomView.addSubview($0)
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
        
        // MARK: - 시가 총액
        topView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        marketCapTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalTo(topView.snp.leading).offset(16)

        }
       
        marketCapLabel.snp.makeConstraints { make in
            make.top.equalTo(marketCapTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(topView.snp.leading).offset(16)
      
        }
        
    
        
        
        // MARK: - 완전 희석 가치
        middleView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(43)
        }
        
        fdvTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(middleView.snp.leading).offset(16)

        }
                
        fdvLabel.snp.makeConstraints { make in
            make.top.equalTo(fdvTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(middleView.snp.leading).offset(16)
           
        }
        

        
        // MARK: - 총 거래량
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(55)
        }
        
        totalVolumeTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(8)
            make.leading.equalTo(bottomView.snp.leading).offset(16)
        }
        
        
        totalVolumeLabel.snp.makeConstraints { make in
            make.top.equalTo(totalVolumeTitleLabel.snp.bottom).offset(4)
            make.leading.equalTo(bottomView.snp.leading).offset(16)
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
