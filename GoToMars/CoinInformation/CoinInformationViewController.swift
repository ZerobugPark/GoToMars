//
//  CoinInfomationViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources


struct Test {
    let name: String
    var items: [Ment]
}

struct Ment {
    let word: String
    
}

extension Test: SectionModelType {
    
    typealias Item = Ment
    
    init(original: Test, items: [Ment]) {
        self = original
        self.items = items
    }
    
    
}



final class CoinInformationViewController: UIViewController {

    
    
    let coninInfoView = CoinInformationView()
    private let disposeBag = DisposeBag()
    
    override func loadView() {
        view = coninInfoView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationConfiguration()
        view.backgroundColor = .white
        test()
        coninInfoView.collectionView.register(CoinInfoCollectionViewCell.self, forCellWithReuseIdentifier: "CoinInfoCollectionViewCell")
    }
    
    
    func test() {
        
        let dataSource = RxCollectionViewSectionedReloadDataSource<Test>  { dataSource, collectionView, indexPath, item in
            
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CoinInfoCollectionViewCell.id, for: indexPath) as? CoinInfoCollectionViewCell else { return UICollectionViewCell() }
            
            cell.numberLabel.text = "\(indexPath.row)"
            
            
            return cell
        }
        
        
        
        let mentor = [
            Test(name: "Jack", items:
                    [Ment(word: "다시 해볼까요?"),
                     Ment(word: "맛점?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?"),
                     Ment(word: "진짠데?")
                     
                    ])]
        
        Observable.just(mentor)
            .bind(to: coninInfoView.collectionView.rx.items(dataSource: dataSource))
            .disposed(by: disposeBag)

    }
    
    
    
    private func navigationConfiguration() {
        
        let view = NavigationTitleView()
        view.titleLabel.text = "가상자산 / 심볼 검색"
        navigationItem.titleView = view
    }
}
