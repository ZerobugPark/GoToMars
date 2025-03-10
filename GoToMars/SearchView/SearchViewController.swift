//
//  SearchViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit

class SearchViewController: UIViewController {

    
    private let searchView = SearchView()
    
    override func loadView() {
        view = searchView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
        searchView.segmentControl.addTarget(self, action: #selector(test), for: .valueChanged)
        
        view.backgroundColor = .white
    }
    
    
    @objc func test() {
        print(#function)
        
        let segmentIndex = CGFloat(searchView.segmentControl.selectedSegmentIndex)
        let segmentWidth = searchView.segmentControl.frame.width / CGFloat(searchView.segmentControl.numberOfSegments)
        let leadingDistance = segmentWidth * segmentIndex
        
        searchView.underLineView.snp.remakeConstraints { make in
            make.top.equalTo(searchView.segmentControl.snp.bottom).offset(1)
            make.leading.equalTo(searchView.segmentControl.snp.leading).offset(leadingDistance)
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.height.equalTo(2)
        }

        
        searchView.layoutIfNeeded()
    }
    


}
