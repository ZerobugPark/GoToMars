//
//  NetworkManager.swift
//  GoToMars
//
//  Created by youngkyun park on 3/6/25.
//

import Foundation

import Alamofire
import RxSwift

enum APIError: Int, Error {
    
    case badRequest = 400   // 잘못된 정보 요청
    case unauthorized = 401 // 허가되지 않은 서명
    case forbidden = 403 // 서버에서 차단되어 요청을 승인할 수 없음
    case baseURLError = 404 // 잘못된 요청 URL
    case tooManyRequests = 429 // 요청 횟수 제한 (잠시 후 다시 시도)
    case internalServerError = 500 // 서버에서 방생한 오류
    case serviceUnavailable   = 503 // 서비스 이용 불가
    case accessDenied = 1020 // CDN 방화벽 규칙 위반
    case apiKeyMissing = 10002 // 잘못된 API키
    case noconnection = 999 // 인터넷 연결 끊김
    case unknown = 99999 // 임의의 에러 값
}

enum APIRequest {
    
    
    case upbit
    case coingeckoTrending
    case coingeckoMarket(id: String)
    case coingeckoSearch(query: String)
    
    var baseURL: String {
        switch self {
        case .upbit:
            APIURLs.upbit
        case .coingeckoTrending:
            APIURLs.coingeckoTrending
        case .coingeckoMarket:
            APIURLs.coingeckoMarket
        case .coingeckoSearch:
            APIURLs.coingeckoSearch
        }
    }
    
    
    var endPoint: URL {
        switch self {
        case .upbit:
            return URL(string: baseURL)!
        case .coingeckoTrending:
            return URL(string: baseURL + "search/trending")!
        case .coingeckoMarket:
            return URL(string: baseURL + "coins/markets")!
        case .coingeckoSearch:
            return URL(string: baseURL + "search")!
        }
        
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var parameter: Parameters? {
        switch self {
        case .upbit:
            let parameters = ["quote_currencies": "KRW"]
            return parameters
        case .coingeckoTrending:
            return nil
        case .coingeckoMarket(let id):
            let parameters = ["vs_currency": "krw", "ids": id, "sparkline": "true"]
            return parameters
        case .coingeckoSearch(let query):
            let parameters = ["query": query]
            return parameters
        }
    }
    
    
    
}


final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() { }
    
    
    func callRequest<T: Decodable>(api: APIRequest, type: T.Type) -> Single<Result<T, APIError>> {
        
        
        return Single<Result<T, APIError>>.create { value in
            
            AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).validate(statusCode: 200...299).responseDecodable(of: T.self) {
                response in
                
                
                switch response.result {
                case .success(let data):
                    value(.success(.success(data)))
                case .failure(let error):
                    dump(error)
                    
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case APIError.test.rawValue:
                            print("tests")
                        case APIError.test2.rawValue:
                            print("t2ests")
                        case APIError.test3.rawValue:
                            print("ddsada")
                        default:
                            print("t2ests22")
                        }
                    }
                    
                    //print(response.response?.statusCode)
                }
                
                
            }
            
            return Disposables.create()
        }
        
       
    }
    
    
    
//    func callRequest() {
//        
//        let api = APIRequest.upbit
//        AF.request(api.endPoint, method: api.method, parameters: api.parameter, encoding: URLEncoding(destination: .queryString)).validate(statusCode: 200...299).responseDecodable(of: [UpBitAPI].self) {
//            response in
//            
//            switch response.result {
//            case .success(let value):
//                dump(value)
//            case .failure(let error):
//                dump(error)
//                
//                print(response.response?.statusCode)
//            }
//            
//            
//        }
//        
//    }
    
    
    
    
}
