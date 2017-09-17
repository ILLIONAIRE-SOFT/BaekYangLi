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
    static let findRoute = "findRoute"
}

struct MetroAPI {
    
    static let server_url = "http://1.238.56.88:3000/"
    
    static func getDestinationInfo(completion: @escaping () -> ()) {
        
        let when = DispatchTime.now() + 1
        DispatchQueue.main.asyncAfter(deadline: when) {
            completion()
        }
    }


    static func getNearestStations(latitude: Double, longitude: Double, completion: @escaping ([Station]) -> ()) {

        Alamofire.request("\(server_url)\(APIType.getNearestStations)/\(latitude)/\(longitude)", method: .get, parameters: nil, encoding: JSONEncoding.default).responseArray { (response: DataResponse<[Station]>) in
            switch response.result {
            case .success:
                if let stations = response.result.value {
                    print(response.result)
                    completion(stations)
                }
            case .failure(let error):
                print(error)
                break
            }
        }
        
    }
    
    static func getDestinationInfos(destination: String, completion: @escaping ([DestinationInfo]) -> ()) {
        let startStation = "백양리"
        let destinationStation = destination
        
        let encodedStart = startStation.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        let encodedDestination = destinationStation.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
        guard let url = URL(string: "\(server_url)\(APIType.findRoute)/\(encodedStart ?? "")/\(encodedDestination ?? "")") else {
            return
        }
        
        Alamofire.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default).responseArray { (response: DataResponse<[DestinationInfo]>) in
            switch response.result {
            case .success:
                if let destinationInfos = response.result.value {
                    completion(destinationInfos)
                } else {
                    completion([])
                }
            case .failure(let err):
                completion([])
                print(err)
                break
            }
        }
    }
    
    
}
