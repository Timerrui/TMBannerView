//
//  ViewController.swift
//  TMSwiftBannerView
//
//  Created by harry on 17/2/7.
//  Copyright © 2017年 timer. All rights reserved.
//

import UIKit
import SDWebImage.UIImageView_WebCache
class ViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let banner:TMSwiftBannerView = TMSwiftBannerView.init(frame: CGRect.init(x: 0, y: 0, width: self.view.frame.size.width, height: 200))
        let array:[String] = ["https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487153665015&di=1e552189349eaae4b7129e84a30dea0c&imgtype=0&src=http%3A%2F%2Fupload.fdc.com.cn%2F2016%2F0219%2F1455843261516.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487153793149&di=6ebbb8f29a9c1fd091a7fda022c6fe3a&imgtype=0&src=http%3A%2F%2Fp.sootoo.com%2Fson_media%2Fmsg%2F2017%2F01%2F13%2F746705.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487748435&di=1fbb5fc0c349b14dbd8bef73d863e8d2&imgtype=jpg&er=1&src=http%3A%2F%2Ftupian.enterdesk.com%2F2012%2F0506%2F4%2F1.jpg","https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=3416824839,3922583864&fm=23&gp=0.jpg","https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1487154052673&di=d2233d99bc4d777e6dda2ec9ff335db5&imgtype=0&src=http%3A%2F%2Fn1.itc.cn%2Fimg8%2Fwb%2Frecom%2F2016%2F05%2F04%2F146235549368743432.JPEG"];

        banner .addImageArray(array)
        banner.delegate = self
        self.view.addSubview(banner)
     
        
        
        
        
        let bannerLocal:TMSwiftBannerView = TMSwiftBannerView.init(frame: CGRect.init(x: 0, y: 300, width: self.view.frame.size.width, height: 200))
        let arrayLocal:[String] = ["banner1","banner2","banner3"];
        bannerLocal.addImageArray(arrayLocal)
        bannerLocal.delegate = self
        self.view.addSubview(bannerLocal)

        
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController:TMSwiftBannerViewDelegate
{
    func imageViewClick(_ index: NSInteger, imageStr: String) {
       print(index,imageStr)
    }
}
