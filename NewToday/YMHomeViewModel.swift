//
//  YMHomeViewModel.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/20.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import RxSwift
import Moya

class YMHomeViewModel {
    private let provider = RxMoyaProvider<NewTodayRequestAPI>()
    
    func getLoadArticleRefreshTip() -> Observable<RefreshTipModel> {
        return provider.request(.loadArticleRefreshTip)
                .filterSuccessfulStatusCodes()
                .mapJSON()
                .mapObject(type: RefreshTipModel.self)
    }
}
