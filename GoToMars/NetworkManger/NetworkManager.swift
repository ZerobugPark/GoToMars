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
    
    case test = 400
    case test2 = 401
    case test3 = 404 // baseURL Error
}

enum APIRequest {
    
    
    case upbit
    case coingeckoTrending
    case coingeckoMarket(id: String)
    
    
    var baseURL: String {
        switch self {
        case .upbit:
            "https://api.upbit.com/v1/ticker/all"
        case .coingeckoTrending:
            "https://api.coingecko.com/api/v3/"
        case .coingeckoMarket:
            "https://api.coingecko.com/api/v3/"
        }
    }
    
    
    var endPoint: URL {
        switch self {
        case .upbit:
            return URL(string: baseURL)!
        case .coingeckoTrending:
            return URL(string: baseURL + "search/trending")!
        case .coingeckoMarket(id: let id):
            return URL(string: baseURL + "coins/markets")!
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
