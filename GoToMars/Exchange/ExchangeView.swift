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
    private let titleLabel = CustomLabel(color: .projectNavy)
    
    let currentPriceView = UIView()
    let currentFilterButton = filterButtonView()
    
    let compareView = UIView()
    let compareViewFilterButton = filterButtonView()
    
    let transactionValueView = UIView()
    let transactionValueFilterButton = filterButtonView()
    
    private let lmarginView = UIView()
    private let rmarginView = UIView()
    
    let tableView = UITableView()
    

    
    override func configureHierarchy() {
        
        
        addSubview(stackView)
        
        [lmarginView, titleView, currentPriceView, compareView, transactionValueView, rmarginView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        titleView.addSubview(titleLabel)
        currentPriceView.addSubview(currentFilterButton)
        compareView.addSubview(compareViewFilterButton)
        transactionValueView.addSubview(transactionValueFilterButton)
        
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
        
        
        transactionValueView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.28)
            make.height.equalTo(30)
        }
        
        transactionValueFilterButton.snp.makeConstraints { make in
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
        
        currentFilterButton.title.text = "현재가"
        compareViewFilterButton.title.text = "전일대비"
        transactionValueFilterButton.title.text = "거래대금"
        
        self.backgroundColor = .white
        
        
        currentPriceView.isUserInteractionEnabled = true
        currentPriceView.tag = 0
        compareView.isUserInteractionEnabled = true
        compareView.tag = 1
        transactionValueView.isUserInteractionEnabled = true
        transactionValueView.tag = 2
        
        tableView.backgroundColor = .red
    }
    
    deinit {
        print("ExchagneView Deinit")
    }
    
}
