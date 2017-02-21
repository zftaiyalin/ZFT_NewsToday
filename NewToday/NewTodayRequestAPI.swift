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
    case loadArticleRefreshTip
    case loadHomeTitlesData(device_id: String, aid: Int, iid: String)
    case Create(title: String, body: String, userId: Int)
}

extension NewTodayRequestAPI: TargetType {
    /// The method used for parameter encoding.
    public var parameterEncoding: ParameterEncoding {
        return URLEncoding.default
    }

    var baseURL: URL {
        return URL(string: "http://lf.snssdk.com/")!
    }
    
    var path: String {
        switch self {
        case .loadArticleRefreshTip:
            return "2/article/v39/refresh_tip/"
        case .loadHomeTitlesData(_, _, _):
            return "article/category/get_subscribed/v1/"
        case .Create(_, _, _):
            return "/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .loadArticleRefreshTip:
            return .get
        case .loadHomeTitlesData(_, _, _):
            return .get
        case .Create(_, _, _):
            return .post
        }
    }
    
    var parameters: [String: Any]? {
        switch self {
        case .loadArticleRefreshTip:
            return nil
        case .loadHomeTitlesData(let device_id,let aid,let iid):
            return ["device_id": device_id, "aid": aid, "iid": iid]
        case .Create(let title, let body, let userId):
            return ["title": title, "body": body, "userId": userId]
        }
    }
    
    var sampleData: Data {
        switch self {
        case .loadArticleRefreshTip:
            return "Create get successfully".data(using: String.Encoding.utf8)!
        case .loadHomeTitlesData(_, _, _):
            return "Create get successfully".data(using: String.Encoding.utf8)!
        case .Create(_, _, _):
            return "Create post successfully".data(using: String.Encoding.utf8)!
        }
    }
    
    var task: Task {
        return .request
    }
}
