//
//  FilterEnum.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import Foundation


enum Filter: Int {
    
    case downTrade = 0 // 거래대금 기준 내림차순
    case upTrade // 거래대금 기준 오름차순
    case donwCompare  // 전앨대비 기준 내림차순
    case upCompare // 전앨대비 기준 오름차순
    case downCurrent // 현재가 기준 내림차순
    case upCurrent // // 현재가 기준 오름차순
    case normal // downPrice와 동일
    
    
    
    
}
