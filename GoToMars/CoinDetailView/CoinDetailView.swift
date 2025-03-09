//
//  CoinDetailView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//

import UIKit
import DGCharts


class CoinDetailView: BaseView {

    private let lineView = UIView()
    
    let chartView = LineChartView()
    
    private let scrollView = UIScrollView()

    private let contentView = UIView()
    private let view2 = UIView()
    let secondSection = DetailInfoView()
    let thiredSection = DetailInfoView()
    let imageView = UIImageView()
    
    private let marginView = UIView()
    
    override func configureHierarchy() {
        
        addSubview(lineView)
        addSubview(scrollView)
        
        
        scrollView.addSubview(contentView)
        
        
        [chartView, secondSection, thiredSection, marginView].forEach {
            contentView.addSubview($0)
        }
        
    }
    
    override func configureLayout() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
        
        
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalTo(self.safeAreaLayoutGuide)
            
            
        }

        
        contentView.snp.makeConstraints { make in
            make.width.equalTo(scrollView.snp.width)
            make.verticalEdges.equalTo(scrollView)
            
        }
        
        
        chartView.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(1000)
            
        }
        chartView.backgroundColor = .blue
        
        secondSection.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(120)
           
        }
        
        thiredSection.snp.makeConstraints { make in
            make.top.equalTo(secondSection.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(170)
            
        }
        
        marginView.snp.makeConstraints { make in
            make.top.equalTo(thiredSection.snp.bottom)
            make.bottom.horizontalEdges.equalTo(contentView)
            make.height.equalTo(10)
        }
        
        
    
        thiredSection.mainStackView.backgroundColor = .red
        marginView.backgroundColor = .black

        
    
        
    }
    
    override func configureView() {
        
        self.backgroundColor = .white
        lineView.backgroundColor = .projectNavy
        
        contentView.backgroundColor = .lightGray
        
       // 종목정보에 총 거래량은 필요 없기때문에,hideen 처리
        secondSection.bottomView.isHidden = true
    }
    

    
    deinit {
        print("CoinInformationView Deinit")
    }
    
    
    
}
