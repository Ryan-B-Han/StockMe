//
//  Record.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import Foundation
import SwiftyJSON

struct Record {
    let date: String
    let open: String
    let high: String
    let low: String
    let close: String
    let volume: String
    
    init(date: String, json: JSON) {
        self.date = date
        let dict = json.dictionaryValue.keyOrganized()
        open = dict["open"]?.stringValue ?? ""
        high = dict["high"]?.stringValue ?? ""
        low = dict["low"]?.stringValue ?? ""
        close = dict["close"]?.stringValue ?? ""
        volume = dict["volume"]?.stringValue ?? ""
    }
}
