//
//  YMScrollTitleView.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/20.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class YMScrollTitleView: UIView {

    /// 存放标题模型的数组
    var titles = [YMHomeTopTitleModel]()
    /// 存放标题 label 数组
    var labels = [YMTitleLabel]()
    /// 存放 label 的宽度
    var labelWidths = [CGFloat]()
    /// 顶部导航栏右边加号按钮点击
    var addBtnClickClosure: (() -> ())?
    /// 点击了一个 label
    var didSelectTitleLable: ((_ titleLabel: YMTitleLabel)->())?
    /// 向外界传递 titles 数组
    var titlesClosure: ((_ titleArray: [YMHomeTopTitleModel])->())?
    /// 记录当前选中的下标
    var currentIndex = 0
    /// 记录上一个下标
    var oldIndex = 0
    
    let disposeBag = DisposeBag()
    let viewModel = YMHomeViewModel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        viewModel.getloadHomeTitlesData(device_id: device_id, aid: 13, iid: IID)
            .subscribe(onNext: { (YMHomeTopTitles: [YMHomeTopTitleModel]) in
                //do something with posts
                print(YMHomeTopTitles.count)
                let model = YMHomeTopTitleModel()
                model.category = "__all__"
                model.name = "推荐"
                self.titles.append(model)
                self.titles += YMHomeTopTitles
                self.setupUI()
                
            })
            .addDisposableTo(disposeBag)
    }
    
    /// 设置 UI
    private func setupUI() {
        // 添加滚动视图
        addSubview(scrollView)
        // 添加按钮
        addSubview(addButton)
        // 布局
        scrollView.snp_makeConstraints { (make) in
            make.left.top.bottom.equalTo(self)
            make.right.equalTo(addButton.snp_left)
        }
        
        addButton.snp_makeConstraints { (make) in
            make.top.bottom.right.equalTo(self)
            make.width.equalTo(30)
        }
        
        addButton.rx.tap
            .subscribe(onNext: { [weak self] in self?.addButtonClick() })
            .addDisposableTo(disposeBag)
        
        /// 添加 label
        setupTitlesLable()
        /// 设置 label 的位置
        setupLabelsPosition()
        // 保存 titles 数组
        titlesClosure?(titles)
    }
    
    /// 暴露给外界，告知外界点击了哪一个 titleLabel
    func didSelectTitleLableClosure(closure:@escaping (_ titleLabel: YMTitleLabel)->()) {
        didSelectTitleLable = closure
    }
    
    /// 暴露给外界，向外界传递 topic 数组
    func titleArrayClosure(closure: @escaping (_ titleArray: [YMHomeTopTitleModel])->()) {
        titlesClosure = closure
    }
    
    /// 设置滚动视图
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    /// 设置添加右边按钮
    lazy var addButton: UIButton = {
        let addButton = UIButton()
        addButton.setImage(UIImage(named: "add_channel_titlbar_16x16_"), for: .normal)
        addButton.setTitleColor(UIColor.white, for: .normal)
        return addButton
    }()
    
    /// 右边添加按钮点击
    func addButtonClick() {
        addBtnClickClosure?()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// 标题点击的方法
    func titleLabelOnClick(tap: UITapGestureRecognizer) {
        guard let  currentLabel = tap.view as? YMTitleLabel else {
            return
        }
        oldIndex = currentIndex
        currentIndex = currentLabel.tag
        let oldLabel = labels[oldIndex]
        oldLabel.textColor = YMColor(r: 235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        currentLabel.textColor = UIColor.white
        currentLabel.currentScale = 1.1
        // 改变 label 的位置
        adjustTitleOffSetToCurrentIndex(currentIndex: currentIndex, oldIndex: oldIndex)
        didSelectTitleLable?(currentLabel)
    }

    /// 添加 label
     func setupTitlesLable() {
        for (index, topic) in titles.enumerated() {
            let label = YMTitleLabel()
            label.text = topic.name
            label.tag = index
            label.textColor = YMColor(r: 235, g: 235, b: 235, a: 1.0)
            label.textAlignment = .center
            label.isUserInteractionEnabled = true
//            let tap = UITapGestureRecognizer(target: self, action: #selector(titleLabelOnClick(_:)))
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(titleLabelOnClick))
            label.addGestureRecognizer(tap)
            label.font = UIFont.systemFont(ofSize: 17)
            label.sizeToFit()
            label.width += kMargin
            labels.append(label)
            labelWidths.append(label.width)
            scrollView.addSubview(label)
            
            
        }
        let currentLabel = labels[currentIndex]
        currentLabel.textColor = UIColor.white
        currentLabel.currentScale = 1.1
    }
    
    /// 设置 label 的位置
    func setupLabelsPosition() {
        var titleX: CGFloat = 0.0
        let titleY: CGFloat = 0.0
        var titleW: CGFloat = 0.0
        let titleH = self.height
        
        for (index, label) in labels.enumerated() {
            titleW = labelWidths[index]
            titleX = kMargin
            if index != 0 {
                let lastLabel = labels[index - 1]
                titleX = lastLabel.frame.maxX + kMargin
            }
            label.frame = CGRect.init(x: titleX, y: titleY, width: titleW, height: titleH)
        }
        /// 设置 contentSize
        if let lastLabel = labels.last {
            scrollView.contentSize = CGSize.init(width: lastLabel.frame.maxX, height: 0)
        }
    }

    
    
    
    /// 当点击标题的时候，检查是否需要改变 label 的位置
    func adjustTitleOffSetToCurrentIndex(currentIndex: Int, oldIndex: Int) {
        guard oldIndex != currentIndex else {
            return
        }
        // 重新设置 label 的状态
        let oldLabel = labels[oldIndex]
        let currentLabel = labels[currentIndex]
        currentLabel.currentScale = 1.1
        currentLabel.textColor = UIColor.white
        oldLabel.textColor = YMColor(r: 235, g: 235, b: 235, a: 1.0)
        oldLabel.currentScale = 1.0
        // 当前偏移量
        var offsetX = currentLabel.centerX - SCREENW * 0.5
        if offsetX < 0 {
            offsetX = 0
        }
        // 最大偏移量
        var maxOffsetX = scrollView.contentSize.width - (SCREENW - addButton.width)
        
        if maxOffsetX < 0 {
            maxOffsetX = 0
        }
        
        if offsetX > maxOffsetX {
            offsetX = maxOffsetX
        }
        scrollView.setContentOffset(CGPoint.init(x: offsetX, y: 0), animated: true)
    }
    
    /// 重写 frame
    override var frame: CGRect {
        didSet {
            let newFrame = CGRect.init(x: 0, y: 0, width: SCREENW, height: 44)
            super.frame = newFrame
        }
    }
}


class YMTitleLabel: UILabel {
    /// 用来记录当前 label 的缩放比例
    var currentScale: CGFloat = 1.0 {
        didSet {
            transform = CGAffineTransform(scaleX: currentScale, y: currentScale)
        }
    }
}
