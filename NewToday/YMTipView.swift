//
//  YMTipView.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/20.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import SnapKit

class YMTipView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = YMColor(r: 215, g: 233, b: 246, a: 1.0)
        addSubview(tipLabel)
        
        tipLabel.snp_makeConstraints { (make) in
            make.edges.equalTo(self)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var tipLabel: UILabel = {
        let tipLabel = UILabel()
        tipLabel.textColor = YMColor(r: 91, g: 162, b: 207, a: 1.0)
        tipLabel.textAlignment = .center
        tipLabel.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
        return tipLabel
    }()

}
