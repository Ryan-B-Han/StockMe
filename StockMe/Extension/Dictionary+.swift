//
//  Dictionary+.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import Foundation
import SwiftyJSON

extension Dictionary where Key == String, Value == JSON {
    // rename key from 1. XXX to XXX
    func keyOrganized() -> Dictionary<String, JSON> {
        var organized: Dictionary<String, JSON> = [:]
        for key in keys {
            let newKey = key
                .trimmingCharacters(in: .decimalDigits)
                .trimmingCharacters(in: CharacterSet(charactersIn: "."))
                .trimmingCharacters(in: .whitespaces)
            organized[newKey] = self[key]
        }
        return organized
    }
}
