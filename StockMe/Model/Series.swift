//
//  Series.swift
//  StockMe
//
//  Created by BYUNGKI HAN on 4/10/22.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Series {
    let meta: Meta
    let records: [Record]
}

extension Series {
    static func request(symbol: String, function: TimeSeries, completionHandler: @escaping (_ error: Error?, _ series: Series?) -> Void) {
        Session.default.request(APIManager.url,
                                method: .get,
                                parameters: ["function": function.rawValue,
                                             "symbol": symbol,
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
                
                let meta = Meta(json: json["Meta Data"])
                var records: [Record] = []
                for (key, value) in json[function.key].dictionaryValue {
                    let rcd = Record(date: key, json: value)
                    records.append(rcd)
                }
                records = records.sorted(by: { $0.date < $1.date })
                let series = Series(meta: meta, records: records)
                completionHandler(nil, series)
            }
        }
    }
    
    enum TimeSeries: String {
        case daily = "TIME_SERIES_DAILY"
        case weekly = "TIME_SERIES_WEEKLY"
        case monthly = "TIME_SERIES_MONTHLY"
        
        var key: String {
            switch self {
            case .daily: return "Daily Time Series"
            case .weekly: return "Weekly Time Series"
            case .monthly: return "Monthly Time Series"
            }
        }
    }
}
