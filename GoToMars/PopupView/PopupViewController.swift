//
//  PopupViewController.swift
//  GoToMars
//
//  Created by youngkyun park on 3/11/25.
//

import UIKit
import RxSwift
import RxCocoa


final class PopupViewController: UIViewController {

    private let popupView = PopupView()
    private let disposeBag = DisposeBag()
    
    
    override func loadView() {
        view = popupView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
    }
    


}
