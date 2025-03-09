//
//  DetailInfoView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/9/25.
//

import UIKit
import SnapKit

final class DetailInfoView: BaseView {

    
    private let mainStackView = UIStackView()

    private let topView = UIView()
    private let middleView = UIView()
    private let bottomView = UIView()
    
    
    let titleLabel = CustomLabel(bold: false, fontSize: 14, color: .projectNavy)
    let moreButton =  CustomButton(buttonImage: "chevron.right", imagePlacement: .trailing)
    
    
    let highPriceTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let highPriceLabel = CustomLabel(bold: false, fontSize: 12, color: .projectNavy)
    
    
    let lowPriceTitleLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    let lowPriceLabel = CustomLabel(bold: false, fontSize: 12, color: .projectNavy)
    
    
    
    
    let athPriceLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    
    
    let atlPriceLabel = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    
    
    let highPrice = CustomLabel(bold: false, fontSize: 12, color: .projectGray)
    
    
    

    
    

    
    override func configureHierarchy() {
        
        self.addSubview(titleLabel)
        self.addSubview(moreButton)
        self.addSubview(mainStackView)

        
        
        [topView, middleView, bottomView].forEach {
            mainStackView.addArrangedSubview($0)
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
       
        topView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        middleView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.height.equalTo(50)
        }
        
    }
    
    override func configureView() {
        
        titleLabel.text = "종목정보"
        
        
        mainStackView.axis = .vertical
        mainStackView.distribution = .fill
        mainStackView.layer.cornerRadius = 10
        mainStackView.clipsToBounds = true
        mainStackView.backgroundColor = .projectGray
        
        mainStackView.spacing = 6
        
        
        topView.backgroundColor = .red
        middleView.backgroundColor = .green
        bottomView.backgroundColor = .blue

    }
    
    deinit {
        print("DetailInfoView Deinit")
    }
    
    
}
