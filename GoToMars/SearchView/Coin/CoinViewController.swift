//
//  CoinViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit
import SnapKit

final class CoinViewController: UIViewController {

    
    private let tableView = UITableView()
    
    var text = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        layout()
        view.backgroundColor = .white
        
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.id)
        
        tableView.rowHeight = 60
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    

  
}


extension CoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.id, for: indexPath) as? CoinTableViewCell else { return UITableViewCell() }
        
        return cell
    }
    
}




// MARK: -  Layout
extension CoinViewController {
    
    private func layout() {
        
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
