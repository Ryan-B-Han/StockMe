//
//  dLog.swift
//  iOSClient
//
//  Created by Han, Ryan on 1/28/21.
//

import Foundation

func dLog(file: String = #file, line: Int = #line, function: String = #function, _ args: Any?...) {
    #if DEBUG
    var log: String = ""
    if let filename = file.components(separatedBy: "/").last {
        log += "[\(filename)]"
    }
    log += "[\(line)] \(function) \(args)"
    print(log)
    #endif
}
