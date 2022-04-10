//
//  Meta.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import Foundation
import SwiftyJSON

struct Meta {
    let symbol: String
    let updatedAt: String
    let timezone: String
    
    init(json: JSON) {
        let dict = json.dictionaryValue.keyOrganized()
        symbol = dict["Symbol"]?.stringValue ?? ""
        updatedAt = dict["Refreshed"]?.stringValue ?? ""
        timezone = dict["Time Zone"]?.stringValue ?? ""
    }
}
