//
//  YMHomeTopTitleModel.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/20.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import ObjectMapper
import Foundation

class YMHomeTopTitleModel: NSObject{
    var category: String!
    var web_url: String!
    var flags: Int!
    var name: String!
    var tip_new: Int!
    var default_add: Int!
    var type: Int!
    var concern_id: String!
    var icon_url: String!
    
    required convenience init?(map: Map) {
        self.init()
        mapping(map: map)
    }
}


extension YMHomeTopTitleModel: Mappable {

    func mapping(map: Map) {
        category        <- map["category"]
        web_url         <- map["web_url"]
        flags           <- map["flags"]
        name            <- map["name"]
        tip_new         <- map["tip_new"]
        default_add     <- map["default_add"]
        type            <- map["type"]
        concern_id      <- map["concern_id"]
        icon_url        <- map["icon_url"]
    }
}


