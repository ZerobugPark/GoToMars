//
//  RecentNesViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit

import SnapKit
import RxCocoa
import RxSwift
import RxDataSources


final class RecentNesViewController: UIViewController {
    
    
    private let viewModel = RecentNewsViewModel()
    private let tableView = UITableView()
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<News> { dataSource, tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "basicCell", for: indexPath)
        

        cell.textLabel?.text = item.title.replacingOccurrences(of: "<[^>]+>|&quot;",
                                                               with: "",
                                                               options: .regularExpression,
                                                               range: nil)
             

        
        return cell
    }
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        configure()
        dataSource.titleForHeaderInSection = { dataSource, index in
            return dataSource.sectionModels[index].title
        }
        
        bind()
        
   
        
    }
    
    private func bind() {
        
        let input = RecentNewsViewModel.Input(callRequest:
                                                Observable<Int>.timer(.seconds(15), scheduler: MainScheduler.instance).startWith(0))
        
        let output = viewModel.transform(input: input)
        
        output.newsData.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
    }
    
    
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "basicCell")
        
        
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
    
}
