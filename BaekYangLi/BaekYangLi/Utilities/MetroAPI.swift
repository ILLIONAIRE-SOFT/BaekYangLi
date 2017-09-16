//
//  MetroAPI.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper
import AlamofireObjectMapper

struct APIType {
    static let getNearestStations = "getNearStations"
}

struct MetroAPI {
    
    static let server_url = "http://172.16.0.35:8000/"
    
    static func getDestinationInfo(completion: @escaping () -> ()) {
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion()
        }
    }
    
    static func getNearestStations(completion: @escaping ([Station]) -> ()) {
        Alamofire.request("\(server_url)\(APIType.getNearestStations)/37.5612/126.9942", method: .get, parameters: nil, encoding: JSONEncoding.default).responseArray { (response: DataResponse<[Station]>) in
            switch response.result {
            case .success:
                if let stations = response.result.value {
                    completion(stations)
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
}
