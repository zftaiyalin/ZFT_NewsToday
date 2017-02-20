//
//  Observable+ObjectMapper.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/20.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import RxSwift
import Moya
import ObjectMapper

extension Observable {
    func mapObject<T: Mappable>(type: T.Type) -> Observable<T> {
        return self.map { response in

            guard let dict = response as? [String: Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().map(JSON: dict["data"] as! [String : Any])!
        }
    }
    
    func mapArray<T: Mappable>(type: T.Type) -> Observable<[T]> {
        return self.map { response in

            guard let array = response as? [Any] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            guard let dicts = array as? [[String: Any]] else {
                throw RxSwiftMoyaError.ParseJSONError
            }
            
            return Mapper<T>().mapArray(JSONArray: dicts)!
        }
    }
}


enum RxSwiftMoyaError: String {
    case ParseJSONError
    case OtherError
}

extension RxSwiftMoyaError: Swift.Error { }
