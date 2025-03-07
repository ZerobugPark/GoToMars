//
//  ExchangeView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit
import SnapKit


final class ExchangeView: BaseView {
    
    
    private let stackView = UIStackView()
    private let titleView = UIView()
    private let titleLabel = CustomLabel(bold: true, fontSize: 14, color: .projectNavy)
    
    let currentPriceView = UIView()
    let currentFilterButton = filterButtonView()
    
    let compareView = UIView()
    let compareViewFilterButton = filterButtonView()
    
    let accTradeView = UIView()
    let accTradeFilterButton = filterButtonView()
    
    private let lmarginView = UIView()
    private let rmarginView = UIView()
    
    let tableView = UITableView()
    

    
    override func configureHierarchy() {
        
        
        addSubview(stackView)
        
        [lmarginView, titleView, currentPriceView, compareView, accTradeView, rmarginView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        titleView.addSubview(titleLabel)
        currentPriceView.addSubview(currentFilterButton)
        compareView.addSubview(compareViewFilterButton)
        accTradeView.addSubview(accTradeFilterButton)
        
        addSubview(tableView)
 
    }
    
    override func configureLayout() {
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(30)
        }
        
        lmarginView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.02)
            make.height.equalTo(30)
        }
        
        titleView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.26)
            make.height.equalTo(30)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(6)
        }
        
        
        currentPriceView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.22)
            make.height.equalTo(30)
        }
        
        
        currentFilterButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview()
            
        
        }
        
        
        compareView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.2)
            make.height.equalTo(30)
        }
        
        
        compareViewFilterButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview()
        
        }
        
        
        accTradeView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.28)
            make.height.equalTo(30)
        }
        
        accTradeFilterButton.snp.makeConstraints { make in
            make.trailing.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.7)
            make.height.equalToSuperview()
        
        }
        
        
        
        rmarginView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.02)
            make.height.equalTo(30)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(stackView.snp.bottom)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
        }
       
        
    }
    
    override func configureView() {
        
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = .projectLightGray
        titleLabel.text = "코인"
        
        currentFilterButton.titleLabel.text = "현재가"
        compareViewFilterButton.titleLabel.text = "전일대비"
        accTradeFilterButton.titleLabel.text = "거래대금"
        
        self.backgroundColor = .white
        
        
        currentPriceView.isUserInteractionEnabled = true
        currentPriceView.tag = 0
        compareView.isUserInteractionEnabled = true
        compareView.tag = 1
        accTradeView.isUserInteractionEnabled = true
        accTradeView.tag = 2
        
        
        tableView.bounces = false
        tableView.separatorStyle = .none

    }
    
    deinit {
        print("ExchagneView Deinit")
    }
    
}
