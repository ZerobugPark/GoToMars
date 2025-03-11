//
//  CoinDetailView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/8/25.
//

import UIKit

import SnapKit
import DGCharts


final class CoinDetailView: BaseView {

    private let lineView = UIView()
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    
    
    let priceLabel = CustomLabel(bold: true, fontSize: 16, color: .projectNavy)
    let statusButton = CustomButton()
    let chartView = LineChartView()
    let dateLabel = CustomLabel(bold: false, fontSize: 9, color: .projectGray)
    let secondSection = DetailInfoView()
    let thirdSection = InvestmentInfoView()
    
    
    private let marginView = UIView()
    
    override func configureHierarchy() {
        
        addSubview(lineView)
        addSubview(scrollView)
        
        
        scrollView.addSubview(contentView)
        
        
        [priceLabel, statusButton, chartView, dateLabel,secondSection, thirdSection, marginView].forEach {
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
        
        priceLabel.snp.makeConstraints { make in
            make.top.horizontalEdges.equalTo(contentView).inset(16)
        }
        
        statusButton.snp.makeConstraints { make in
            make.top.equalTo(priceLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView).inset(8)
        }
        
        chartView.snp.makeConstraints { make in
            make.top.equalTo(statusButton.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(16)
            make.height.equalTo(300)
            
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(chartView.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView).inset(16)
            
        }
        
        secondSection.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(8)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(160)
           
        }
        
        thirdSection.snp.makeConstraints { make in
            make.top.equalTo(secondSection.snp.bottom).offset(4)
            make.horizontalEdges.equalTo(contentView)
            make.height.equalTo(190)
            
        }
                
        marginView.snp.makeConstraints { make in
            make.top.equalTo(thirdSection.snp.bottom)
            make.bottom.horizontalEdges.equalTo(contentView)
            make.height.equalTo(10)
        }
        
        
    }
    
    override func configureView() {
        
        self.backgroundColor = .white
        lineView.backgroundColor = .projectNavy
                
        scrollView.showsVerticalScrollIndicator = false
        contentView.backgroundColor = .white
            
        chartView.noDataText = "조회할 수 있는 차트 데이터가 없습니다."
        chartView.noDataFont = .boldSystemFont(ofSize: 12)
        chartView.noDataTextColor = .projectNavy

    
        secondSection.titleLabel.text = "종목정보"
        thirdSection.titleLabel.text = "투자지표"
        
        
        chartView.legend.enabled = false // 범례제거
        chartView.rightAxis.enabled = false // 오른쪽 축 값 표시 제거
        chartView.leftAxis.enabled = false // 왼쪽 축 값 표시 제거
        chartView.doubleTapToZoomEnabled = false // 줌 제거
        chartView.xAxis.drawGridLinesEnabled = false // x축 표시 제거
        chartView.xAxis.drawAxisLineEnabled = false // 위에 표시 제거
        chartView.xAxis.drawLabelsEnabled = false // 레이블 제거

        
    }
    

    
    deinit {
        print("CoinInformationView Deinit")
    }
    
    
    
}


