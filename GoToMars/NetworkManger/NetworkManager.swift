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
    case internalServerError = 500 // 서버에서 발생한 오류
    case serviceUnavailable   = 503 // 서비스 이용 불가
    case accessDenied = 1020 // CDN 방화벽 규칙 위반
    case apiKeyMissing = 10002 // 잘못된 API키
    case noconnection = 999 // 인터넷 연결 끊김
    case unknown = 99999 // 임의의 에러 값
    
    
    
    var message: String {
        switch self {
        case .badRequest:
            return "잘못된 정보 요청"
        case .unauthorized:
            return "허가되지 않은 서명"
        case .forbidden:
            return "서버에서 차단되어 요청을 승인할 수 없음"
        case .baseURLError:
            return "잘못된 요청 URL"
        case .tooManyRequests:
            return "요청 횟수 제한 (잠시 후 다시 시도)"
        case .internalServerError:
            return "서버에서 발생한 오류"
        case .serviceUnavailable:
            return "서비스 이용 불가"
        case .accessDenied:
            return "CDN 방화벽 규칙 위반"
        case .apiKeyMissing:
            return "잘못된 API키"
        case .noconnection:
            return "인터넷 연결 끊김"
        case .unknown:
            return "임의의 에러 값"
        }
    }
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
                    
                    print(response.response?.statusCode)
                    if let statusCode = response.response?.statusCode {
                        switch statusCode {
                        case APIError.badRequest.rawValue:
                            value(.success(.failure(APIError.badRequest)))
                        case APIError.unauthorized.rawValue:
                            value(.success(.failure(APIError.unauthorized)))
                        case APIError.forbidden.rawValue:
                            value(.success(.failure(APIError.forbidden)))
                        case APIError.baseURLError.rawValue:
                            value(.success(.failure(APIError.baseURLError)))
                        case APIError.tooManyRequests.rawValue:
                            value(.success(.failure(APIError.tooManyRequests)))
                        case APIError.internalServerError.rawValue:
                            value(.success(.failure(APIError.internalServerError)))
                        case APIError.serviceUnavailable.rawValue:
                            value(.success(.failure(APIError.serviceUnavailable)))
                        case APIError.accessDenied.rawValue:
                            value(.success(.failure(APIError.accessDenied)))
                        case APIError.apiKeyMissing.rawValue:
                            value(.success(.failure(APIError.apiKeyMissing)))
                        default:
                            value(.success(.failure(APIError.unknown)))
                        }
                    }
                    
                }
                
                
            }
            
            return Disposables.create()
        }
        
       
    }

    
}
