//
//  CollectionHeaderReusableView.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import UIKit
import SnapKit

final class CollectionHeaderReusableView: UICollectionReusableView {
      
    static let id = "CollectionHeaderReusableView"
    
    let titleLabel = CustomLabel(bold: true, fontSize: 16, color: .projectNavy)
    let timeLabel = CustomLabel(bold: false, fontSize: 14, color: .projectGray)
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configurationLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configurationLayout() {
   
        addSubview(titleLabel)
        addSubview(timeLabel)
        
        
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            
        }
        
        timeLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.trailing.equalTo(self.safeAreaLayoutGuide).offset(-16)
        }
        
    
    }
}
