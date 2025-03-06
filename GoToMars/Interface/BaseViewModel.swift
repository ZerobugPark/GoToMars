//
//  BaseViewModel.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import Foundation

protocol BaseViewModel {
    associatedtype Input
    associatedtype Output
    
    func transform(input: Input) -> Output
}
