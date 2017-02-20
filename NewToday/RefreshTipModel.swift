//
//  RefreshTipModel.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/20.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import ObjectMapper

class RefreshTipModel: Mappable {
    var count: Int!
    var tip: String!
    
    
    required init?(map: Map) {
    }
    
    func mapping(map: Map) {
        count   <- map["count"]
        tip     <- map["tip"]
    }
}
