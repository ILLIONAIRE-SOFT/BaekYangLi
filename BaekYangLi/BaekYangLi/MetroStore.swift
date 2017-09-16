//
//  MetroStore.swift
//  BaekYangLi
//
//  Created by LEOFALCON on 2017. 9. 16..
//  Copyright © 2017년 BaekYangLi. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper


class MetroStore {
    
    static let shared: MetroStore = MetroStore()
    static var stations: [Station]! = nil
    
    static func fetchStations(latitude : Double, longitude : Double) {
        let urlString = "http://172.16.0.35:8000/getNearStations"+"\(latitude)"+"\(longitude)"
        
//        Alamofire.request(urlString).responseJSON { response in
//            guard let json = response.result.value as? [[String : Any]]
//                else { return }
//            let line : Line = json.flatMap {
//                guard let name = $0["name"] as? String else { return nil }
//                guard let stationID = $0["station_id"] as? Int else { return nil }
//                guard let latitude = $0["lat"] as? Double else { return nil }
//                guard let longitude = $0["lng"] as? Double else { return nil }
//                
//                return Line(name: name, stationID: stationID, latitude: latitude, longitude: longitude, up: [], down: [])
//            }
//        }
        
    }

//    func searchSchools(_ query: String) {
//        let urlString = "http://schoool.xoul.kr/school/search"
//        let parameters = ["query": query]
//
//        Alamofire.request(urlString, method: .get, parameters: parameters)
//            .responseJSON { response in
//                guard let json = response.result.value as? [String: [[String: Any]]],
//                    let dicts = json["data"]
//                    else { return }
//                self.schools = dicts.flatMap {
//                    guard let code = $0["code"] as? String else { return nil }
//                    guard let type = $0["type"] as? String else { return nil }
//                    guard let name = $0["name"] as? String else { return nil }
//                    return School(code: code, type: type, name: name)
//                }
//                self.tableView.reloadData()
//        }
//    }
}
