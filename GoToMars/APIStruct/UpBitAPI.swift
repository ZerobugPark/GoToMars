//
//  UpBitAPI.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import Foundation


struct UpBitAPI: Decodable {
    
    //현재가
    // 전일대비 (비율, 금액(
    //거래대금
    var market: String
    let change: String
    let changePrice: Double
    let changeRate: Double
    let trade: Double
    let accTrade: Double
    
    
    enum CodingKeys: String, CodingKey {
        case market
        case change
        case changePrice = "signed_change_price"
        case changeRate = "signed_change_rate"
        case trade = "trade_price"
        case accTrade = "acc_trade_price_24h"
    }
 
}
