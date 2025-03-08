//
//  CoinGeckoAPI.swift
//  GoToMars
//
//  Created by youngkyun park on 3/7/25.
//

import Foundation

struct CoinGeckoTrendingAPI: Decodable {
    let coins: [TrendingCoinItem]
    let nfts: [Nfts]
}

struct TrendingCoinItem: Decodable {
    let item: TrendingCoinDetails
}

struct TrendingCoinDetails: Decodable {
    let id: String
    let name: String
    let symbol: String
    let thumb: String
    let data: Data
    
}

struct Data: Decodable {
    
    var pricePercent: [String: Double]
    let krwPrice: Double
    
    enum CodingKeys: String, CodingKey {
        case pricePercent = "price_change_percentage_24h"

    }
    
    init(from decoder: any Decoder) throws {
        // 서버에서 받은 데이터를 한번 더 확인
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        pricePercent = try container.decode([String:Double].self, forKey: .pricePercent)
        
        krwPrice = pricePercent["krw"] ?? 1000000.0 //백만을 넘을 수 있을까?.. 나도 사고싶네
        
    }
}



struct Nfts: Decodable {
    let name: String
    let symbol: String
    let thumb: String
    let pricePercent: Double
    
    
    enum CodingKeys: String, CodingKey {
        case name
        case symbol
        case thumb
        case pricePercent = "floor_price_24h_percentage_change"

    }
    

}


struct CoinGeckoMarketAPI: Decodable {
    // 목데이터에는 널인게 있네? 커스텀 디코딩 해놔야겠네
    
    let id: String
    let symbol: String
    let name: String
    let image: String
    
    
    let current_price: Double
    let market_cap: Double  //시가총액
    
    let high_24h: Double // 24시간 고가
    let low_24h: Double // 24시간 초저
   
    let total_volume: Double  // 총거래량
    let fully_diluted_valuation: Double // 완전희석가치
    let ath: Double // 역대 최고가
    let ath_date: Double // 최고가 날자
    let atl: Double // 역대 최저가
    let atl_date: Double // 최저가 날짜
    
    let sparkline_in_7d: [String: [Double]]
}




