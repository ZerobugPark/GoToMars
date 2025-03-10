//
//  NetworkStatus.swift
//  GoToMars
//
//  Created by youngkyun park on 3/11/25.
//

import Foundation
import Network


final class NetworkMonitor {
    
    static let shared = NetworkMonitor()
    private let monitor = NWPathMonitor()
    private let queue = DispatchQueue.global(qos: .background)
    
    
    private(set) var inConnected: Bool = false
    private(set)var connectionType: ConnectionType = .unknown
    
    private init() {}
    
    
    enum ConnectionType {
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    
    
    func startMonitoring() {
        
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.inConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
        }
        
        
    }
    
    func stopMonitoring() {
        print("stopMonitoring 호출")
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath) {
        print("연결 상태 확인")
        
        if path.usesInterfaceType(.wifi) {
            connectionType = .wifi
            print("wifi에 연결")
        } else if path.usesInterfaceType(.cellular) {
            print("셀룰러 연결")
        } else if path.usesInterfaceType(.wiredEthernet) {
            print("wiredEthernet에 연결")
        } else {
            connectionType = .unknown
            print("알수 없음")
            
        }
    }
    
    
    
}
