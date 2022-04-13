//
//  Stock.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import Foundation
import SwiftyJSON
import Alamofire
import CoreData

struct Stock: Identifiable, Codable {
    var id = UUID()
    let symbol: String
    var name: String
    var type: String
    var region: String
    var marketOpen: String
    var marketClose: String
    var timezone: String
    var currency: String
    var matchScore: String
    
    init(json: JSON) {
        let dic = json.dictionaryValue.keyOrganized()
        symbol = dic["symbol"]?.stringValue ?? ""
        name = dic["name"]?.stringValue ?? ""
        type = dic["type"]?.stringValue ?? ""
        region = dic["region"]?.stringValue ?? ""
        marketOpen = dic["marketOpen"]?.stringValue ?? ""
        marketClose = dic["marketClose"]?.stringValue ?? ""
        timezone = dic["timezone"]?.stringValue ?? ""
        currency = dic["currency"]?.stringValue ?? ""
        matchScore = dic["matchScore"]?.stringValue ?? ""
    }
    
    init(favorite: Favorite) {
        symbol = favorite.symbol!
        name = favorite.name!
        type = favorite.type!
        region = favorite.region!
        marketOpen = favorite.marketOpen!
        marketClose = favorite.marketClose!
        timezone = favorite.timezone!
        currency = favorite.currency!
        matchScore = favorite.matchScore!
        
    }
}

extension Stock {
    static func request(keywords: String, completionHandler: @escaping (_ error: Error?, _ stocks: [Stock]?) -> Void) {
        Session.default.request(APIManager.url,
                                method: .get,
                                parameters: ["function": "SYMBOL_SEARCH",
                                             "keywords": keywords,
                                             "apikey": APIManager.apiKey],
                                encoding: URLEncoding.default)
        .responseData { response in
            switch response.result {
            case .failure(let error):
                completionHandler(error, nil)
            case .success(let data):
                let json = JSON(data)
                if let note = json["Note"].string {
                    let error = NSError(domain: "stockme", code: -1, userInfo: [NSLocalizedFailureReasonErrorKey: note])
                    completionHandler(error, nil)
                    return
                }
                
                var stocks: [Stock] = []
                for item in json["bestMatches"].arrayValue {
                    let stock = Stock(json: item)
                    stocks.append(stock)
                }
                
                completionHandler(nil, stocks)
            }
        }
    }
}
