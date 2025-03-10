//
//  SearchViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/10/25.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

final class SearchViewController: UIViewController {
    
    private let searchView = SearchView()
    
    private let leftBackButton =  UIBarButtonItem(image: UIImage(systemName: "arrow.left"), style:.plain, target: nil, action: nil)
    
    private lazy var textField = UITextField(frame: CGRect(x: 30, y: 0, width: (navigationController?.navigationBar.frame.size.width)! - 30.0, height: 30))
    
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    
    private let disposeBag = DisposeBag()
    
    private let firstVC = CoinViewController()
    private let secondVC = NFTViewController()
    private let thridVC = MarketViewController()

    
    private lazy var dataViewControllers: [UIViewController] = [firstVC, secondVC, thridVC]
    
    var searchText = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
 
        // 첫번째 화면 설정
        // 이때. 뷰컨 viewdidLoad 시점
        pageViewController.setViewControllers([firstVC], direction: .forward, animated: true, completion: nil)
        
        textField.text = searchText
    
        
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        layout()
        navigationConfiguration()
        bind()
       
     
    }
    
    
    
    
    private func bind() {
        
        searchView.segmentControl.rx.selectedSegmentIndex.bind(with: self) { owner, index in
            
            owner.changeUnderlinePosition(index: index)
            owner.changeViewController(index: index)
        }.disposed(by: disposeBag)
        
        leftBackButton.rx.tap.bind(with: self) { owner, _ in
            owner.navigationController?.popViewController(animated: true)
        }.disposed(by: disposeBag)
        
        textField.rx.controlEvent(.editingDidEnd).withLatestFrom(textField.rx.text.orEmpty).distinctUntilChanged().startWith(searchText).bind(with: self) { owner, value in
            
            print("ee")
            owner.firstVC.viewModel.query = value
            
        }.disposed(by: disposeBag)
        
    }
    
    
    
    private func navigationConfiguration() {
        
        navigationItem.titleView = textField
        navigationItem.leftBarButtonItem = leftBackButton
        
    }
    
    
}

// MARK: - Layout
extension SearchViewController {
    
    private func layout() {
        view.addSubview(searchView)
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        
        searchView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.height.equalTo(42)
            
        }
        
        pageViewController.view.snp.makeConstraints { make in
            make.top.equalTo(searchView.snp.bottom).offset(4)
            make.horizontalEdges.bottom.equalToSuperview()
        }
        pageViewController.view.backgroundColor = .blue
        
        
    }
}


// MARK: - PageController DataSource / Delegate
extension SearchViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        
        return dataViewControllers[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        
        return dataViewControllers[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        if completed {
            if let currentVC = pageViewController.viewControllers?.first,
               let currentIdx = dataViewControllers.firstIndex(of: currentVC) {
                changeUnderlinePosition(index: currentIdx)
            }
            
        } else {
            print("페이지 전환 실패")
        }
        
    }
}


// MARK: - SegmentController And UnderLine
extension SearchViewController {
    
    private func changeUnderlinePosition(index: Int) {
        
        let segmentIndex = CGFloat(index)
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
    
    private func changeViewController(index: Int) {
        
        guard let currentVC = pageViewController.viewControllers?.first, let previousIndex = dataViewControllers.firstIndex(of: currentVC) else { return }
        
        if previousIndex < index {
            pageViewController.setViewControllers([dataViewControllers[searchView.segmentControl.selectedSegmentIndex]], direction: .forward, animated: true)
            
        } else if previousIndex > index {
            pageViewController.setViewControllers([dataViewControllers[searchView.segmentControl.selectedSegmentIndex]], direction:  .reverse, animated: true)
        } else { }
        
        
        
    }
}
