//
//  NewTodayRequestAPI.swift
//  NewToday
//
//  Created by 安风 on 2017/2/13.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import RxSwift
import Moya

enum NewTodayRequestAPI {
    case Show
    case Create(title: String, body: String, userId: Int)
}

extension NewTodayRequestAPI: TargetType {
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return self.parameterEncoding
    }

    var baseURL: URL {
        return URL(string: "http://jsonplaceholder.typicode.com")!
    }
    
    var path: String {
        switch self {
        case .Show:
            return "/posts"
        case .Create(_, _, _):
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .Show:
            return .get
        case .Create(_, _, _):
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .Show:
            return nil
        case .Create(let title, let body, let userId):
            return ["title": title, "body": body, "userId": userId]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .Show:
            return "[{\"userId\": \"1\", \"Title\": \"Title String\", \"Body\": \"Body String\"}]".data(using: String.Encoding.utf8)!
        case .Create(_, _, _):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
}
