//
//  DestinationInfo.swift
//  BaekYangLi
//
//  Created by Sohn on 16/09/2017.
//  Copyright © 2017 BaekYangLi. All rights reserved.
//

import Foundation
import ObjectMapper

class DestinationInfo: Mappable {
    
    var statnFnm: String?
    var statnTnm: String?
    var shtTransferMsg: String?
    var shtStatnNm: String?
    var shtStatnId: [String]?
    var shtStatnCnt: String?
    var shtTravelTm: String?
    var shtTransferCnt: String?
    
    required init?(map: Map) {
        
    }
    
    func mapping(map: Map) {
        statnFnm <- map["statnFnm"]
        statnTnm <- map["statnTnm"]
        shtTransferMsg <- map["shtTransferMsg"]
        shtStatnNm <- map["shtStatnNm"]
        shtStatnId <- map["shtStatnId"]
        shtStatnCnt <- map["shtStatnCnt"]
        shtTravelTm <- map["shtTravelTm"]
        shtTransferCnt <- map["shtTransferCnt"]
    }
}
