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
    private let tableView = UITableView(frame: .zero, style: .plain)
    private let disposeBag = DisposeBag()
    
    private lazy var dataSource = RxTableViewSectionedReloadDataSource<News> { dataSource, tableView, indexPath, item in
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "BasicCell", for: indexPath)
        
        cell.selectionStyle = .none
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
        
        //헤더 셋팅
        let headerLabelAppearance = UILabel.appearance(whenContainedInInstancesOf: [UITableViewHeaderFooterView.self])
        headerLabelAppearance.textColor = .projectNavy // 폰트컬러
        headerLabelAppearance.font = .boldSystemFont(ofSize: 16)
        UITableViewHeaderFooterView.appearance().tintColor = .white //백그라운드

        navigationItem.backButtonTitle = ""
        
    }
    
    private func bind() {
        
        let input = RecentNewsViewModel.Input(callRequest:
                                                Observable<Int>.timer(.seconds(60), scheduler: MainScheduler.instance).startWith(0))
        
        let output = viewModel.transform(input: input)
        
        output.newsData.asDriver(onErrorJustReturn: []).drive(tableView.rx.items(dataSource: dataSource)).disposed(by: disposeBag)
        
        
        
        tableView.rx.itemSelected.bind(with: self) { owner, indexPath in
            
            let data = owner.dataSource[indexPath.section].items[indexPath.row]
            
            let vc = WebViewController()
            
            vc.url = data.originallink
            
            owner.navigationController?.pushViewController(vc, animated: true)
            
            
        }.disposed(by: disposeBag)
        
    
    
    }
    
    
    
    private func configure() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
    
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BasicCell")
        tableView.delegate = self

        tableView.snp.makeConstraints { make in
            make.edges.equalTo(view.safeAreaLayoutGuide)
        }
        
        tableView.bounces = false
        tableView.showsVerticalScrollIndicator = false
        
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0
        }
  
    }
    
}



extension RecentNesViewController: UITableViewDelegate {
 

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    
}
