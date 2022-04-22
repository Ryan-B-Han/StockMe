//
//  AppConfig.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/22/22.
//

import Foundation

enum AppConfig {
    case debug
    case testFlight
    case appStore
    
    static var current: AppConfig {
#if DEBUG
        return .debug
#else
        if let environ = ProcessInfo.processInfo.environment["APP_SANDBOX_CONTAINER_ID"] {
            return .testFlight
        } else {
            return .appStore
        }
#endif
    }
    
    var string: String {
        switch self {
        case .debug: return "debug"
        case .testFlight: return "testFlight"
        case .appStore: return "appStore"
        }
    }
}
