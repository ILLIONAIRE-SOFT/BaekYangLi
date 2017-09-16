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


struct APIType {
    static let getNearestStations = "getNearStations"
}

struct MetroAPI {
    
    static let server_url = "172.16.0.35:8000/"
    
    static func getDestinationInfo(completion: @escaping () -> ()) {
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion()
        }
    }
    
    static func getNearestStations(completion: @escaping ([Station]) -> ()) {
        Alamofire.request("\(server_url)\(APIType.getNearestStations)", method: .get, parameters: nil, encoding: JSONEncoding.default)
//        Alamofire.request(<#T##url: URLConvertible##URLConvertible#>, method: <#T##HTTPMethod#>, parameters: <#T##Parameters?#>, encoding: <#T##ParameterEncoding#>, headers: <#T##HTTPHeaders?#>)
        
    }
    
}
