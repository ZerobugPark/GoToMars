//
//  PopupView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/11/25.
//

import UIKit
import SnapKit

final class PopupView: BaseView {

    private let view  = UIView()
    private let title = CustomLabel(bold: true, fontSize: 16, color: .projectNavy)
    private let subtitle = CustomLabel(bold: false, fontSize: 14, color: .projectGray)

    private let lineView = UIView()
    private let restartButton = UIButton()
    
    override func configureHierarchy() {
        
        addSubview(view)
        
        [title, subtitle, lineView, restartButton].forEach {
            view.addSubview($0)
        }
    
    }
    
    override func configureLayout() {

        view.snp.makeConstraints { make in
            make.center.equalTo(self.safeAreaLayoutGuide)
            make.width.equalTo(self.snp.width).multipliedBy(1.0 / 1.2)
            make.height.equalTo(self.snp.width).multipliedBy(1.0 / 2.5)
        }
        
        title.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.centerX.equalToSuperview()
        }
        
        subtitle.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(self.snp.width).multipliedBy(1.0 / 1.4)
        }
        
        
        lineView.snp.makeConstraints { make in
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(1)
            make.bottom.equalTo(restartButton.snp.top).offset(-1)
        }
        
        restartButton.snp.makeConstraints { make in
            
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        
    }
    
    override func configureView() {
    
        self.backgroundColor = .black
        //스토리보드의 Opacity와 같은 역할
        self.backgroundColor = UIColor.black.withAlphaComponent(0.5)
    
        view.backgroundColor = .white
        title.text = "안내"
        subtitle.text = "네트워크 연결이 일시적으로 원할하지 않습니다. 데이터 또는 Wi-Fi 연결 상태를 확인해주세요."
        subtitle.numberOfLines = 0
        subtitle.textAlignment = .center
        restartButton.setTitle("다시 시도하기", for: .normal)
        restartButton.setTitleColor(.projectNavy, for: .normal)
        lineView.backgroundColor = .projectGray

    }

}
