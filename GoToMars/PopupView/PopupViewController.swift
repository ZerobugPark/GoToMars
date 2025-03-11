//
//  PopupViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/11/25.
//

import UIKit

import Toast
import RxSwift
import RxCocoa



final class PopupViewController: UIViewController {

    private let popupView = PopupView()
    private let disposeBag = DisposeBag()
    let connectedNetwork = PublishRelay<Void>()
    
    override func loadView() {
        view = popupView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    private func bind() {
        
        // 다시시도하기 버튼을 누르지 않더라도, 네트워크 연결이 되면 이전 화면으로 돌아가기
        Observable<Int>.interval(.seconds(10), scheduler: MainScheduler.instance).bind(with: self) { owner, _ in
            
            if NetworkMonitor.shared.isConnected {
                
                owner.view.makeToast("네트워크에 연결되었습니다.")
                owner.connectedNetwork.accept(())
                owner.dismiss(animated: true)
                
            } else {
                owner.view.makeToast("네트워크 연결이 원활하지 않습니다.")
            }
            
        }.disposed(by: disposeBag)
        
        popupView.restartButton.rx.tap.bind(with: self) { owner, _ in
            
            owner.view.makeToast("네트워크 연결을 다시 시도합니다.")
            
            if NetworkMonitor.shared.isConnected {
                owner.view.makeToast("네트워크에 연결되었습니다.")
                owner.connectedNetwork.accept(())
                owner.dismiss(animated: true)
            }
            
        }.disposed(by: disposeBag)
        
    }
    


}
