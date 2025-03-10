//
//  SearchView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit
import SnapKit

final class SearchView: BaseView {

    private let lineView = UIView()
    private let container = UIView()
    let segmentControl = UISegmentedControl()
    let underLineView = UIView()
    let baseLineView = UIView()
    
//    lazy var leadingDistanc: NSLayoutConstraint = {
//        return underLineView.snp.updateConstraints { make in
//
//        }
//    }
    
    
    override func configureHierarchy() {
        
        addSubview(lineView)
        addSubview(container)
        container.addSubview(segmentControl)
        container.addSubview(underLineView)
        container.addSubview(baseLineView)

    }
    
    override func configureLayout() {
        
        lineView.snp.makeConstraints { make in
            make.top.equalTo(self.safeAreaLayoutGuide)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(1)
        }
   
        container.snp.makeConstraints { make in
            make.top.equalTo(lineView.snp.bottom).offset(1)
            make.horizontalEdges.equalTo(self.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        segmentControl.snp.makeConstraints { make in
            make.top.equalTo(container)
            make.horizontalEdges.equalTo(container)
            make.height.equalTo(37)
        }
        
        underLineView.snp.makeConstraints { make in
            
            make.top.equalTo(segmentControl.snp.bottom)
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.leading.equalTo(container.safeAreaLayoutGuide)
            make.height.equalTo(2)
        }

        baseLineView.snp.makeConstraints { make in
            make.top.equalTo(underLineView.snp.bottom)
            make.horizontalEdges.equalTo(container)
            make.height.equalTo(1)
        }


    }
    
    override func configureView() {
        
        lineView.backgroundColor = .projectGray
        segmentControl.selectedSegmentTintColor = .clear
        
        // 배경색 제거
        segmentControl.setBackgroundImage(UIImage(), for: .normal, barMetrics: .default)
        
        // Segment 구분 라인 제거
        segmentControl.setDividerImage(UIImage(), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        
        
        segmentControl.insertSegment(withTitle: "코인", at: 0, animated: true)
        segmentControl.insertSegment(withTitle: "NFT", at: 1, animated: true)
        segmentControl.insertSegment(withTitle: "거래소", at: 2, animated: true)
        
        segmentControl.selectedSegmentIndex = 0
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.projectGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12) ], for: .normal)
        
        segmentControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.projectNavy, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12) ], for: .selected)
        
        underLineView.backgroundColor = .projectNavy
        baseLineView.backgroundColor = .projectGray
        
    }
    
    
    
    
    
    

}
