//
//  YMHomeViewController.swift
//  NewToday
//
//  Created by 曾富田 on 2017/2/13.
//  Copyright © 2017年 安风. All rights reserved.
//

import UIKit
import RxSwift

class YMHomeViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    let viewModel = YMHomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
3
        // Do any additional setup after loading the view.
        
        viewModel.getLoadArticleRefreshTip()
            .subscribe(onNext: { (RefreshTip: RefreshTipModel) in
                //do something with posts
                print(RefreshTip.tip)
                print(RefreshTip.count)
                
                self.tipView.tipLabel.text = (RefreshTip.count == 0) ? "暂无更新，请休息一会儿" : "今日头条推荐引擎有\(RefreshTip.count!)条刷新"
                UIView.animate(withDuration: kAnimationDuration, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 10, options: UIViewAnimationOptions(rawValue: 0), animations: {
                    
                    self.tipView.tipLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    let delayTime: DispatchTime = DispatchTime.now() + 2
                    DispatchQueue.main.asyncAfter(deadline: delayTime) {
                        self.tipView.isHidden = true
                    }
 
                }, completion: { (Bool) in
                    
                })
                
            })
            .addDisposableTo(disposeBag)
    }
    
    
    private func setupUI() {
        view.backgroundColor = YMGlobalColor()
        //不要自动调整inset
        automaticallyAdjustsScrollViewInsets = false
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.barTintColor = YMColor(r: 210, g: 63, b: 66, a: 1.0)
        
//        navigationItem.titleView = tit
        
    }

    /// 每次刷新显示的提示标题
    
    private lazy var tipView: YMTipView = {
        let tipView = YMTipView()
        tipView.frame = CGRect.init(x: 0, y: 44, width: SCREENW, height: 35)
        // 加载 navBar 上面，不会随着 tableView 一起滚动
        self.navigationController?.navigationBar.insertSubview(tipView, at: 0)
        return tipView
    }()
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
