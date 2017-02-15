//
//  TMSwiftBannerView.swift
//  TMSwiftBannerView
//
//  Created by harry on 17/2/7.
//  Copyright © 2017年 timer. All rights reserved.
//

import UIKit
import SDWebImage

protocol TMSwiftBannerViewDelegate {
    func imageViewClick(_ index:NSInteger,imageStr:String)
}

class TMSwiftBannerView: UIView
{
    
    var delegate:TMSwiftBannerViewDelegate?
    var timer: DispatchSourceTimer?
    var pageStepTime: DispatchTimeInterval = .seconds(5)
    var backScrollView:UIScrollView?
    
    var pageControl :TMPageControl?
    
    lazy var imageArray:NSMutableArray =
    {
        var array = NSMutableArray()
        return array
    
    }()
    
    override init(frame: CGRect)
    {
        super.init(frame: frame)
        
        backScrollView = UIScrollView.init(frame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        self.addSubview(backScrollView!)
        backScrollView?.backgroundColor = UIColor.red
        backScrollView?.delegate = self
        
        pageControl = TMPageControl.init(frame: CGRect.init(x: 0, y: self.frame.size.height-30, width: self.frame.size.width, height: 30))
        addSubview(pageControl!)
        pageControl?.currentPage = 0
//        pageControl?.delete = self
        
        
        
        
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addImageArray(_ array:[String])
    {
        if array.count <= 0{
            return
        }
        
         self.imageArray.addObjects(from: array )
         self.imageArray.insert(array.last as Any, at: 0)
         self.imageArray.add(array[0])
        
        
        for index in 0...self.imageArray.count-1
        {
            let imageView:UIImageView = UIImageView.init()
            imageView.tag = index
            imageView.isUserInteractionEnabled = true
            imageView.frame = CGRect.init(x: CGFloat(index)*self.frame.size.width, y: 0, width: self.frame.size.width, height: self.frame.size.height)
            let imageStr:String =  self.imageArray[index] as! String
            if (imageStr.hasPrefix("http") || imageStr.hasPrefix("https"))
            {
              imageView.sd_setImage(with: NSURL.init(string: imageStr) as URL?, placeholderImage: UIImage.init(named: "banner1"))
            }
            else
            {
            imageView.image = UIImage.init(named: self.imageArray[index] as! String)
            }
            backScrollView?.addSubview(imageView)
            
            
            let tap = UITapGestureRecognizer.init(target: self, action:#selector(tapClick(_:)))
            imageView.isUserInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
            
            
            
        }
        
        backScrollView?.contentSize = CGSize.init(width:CGFloat((self.backScrollView?.subviews.count)!)*self.frame.size.width, height: 0)
        backScrollView?.contentOffset = CGPoint.init(x: self.frame.size.width, y: 0)
        backScrollView?.showsHorizontalScrollIndicator = false
        backScrollView?.isPagingEnabled = true
        self.pageControl?.numberOfPages = array.count
        
        self.timerStart()
    }
    
    

    
    func timerStart()
    {
        if timer == nil {
            timer = DispatchSource.makeTimerSource(queue: DispatchQueue.global())
            timer?.scheduleRepeating(deadline: .now()+pageStepTime, interval: pageStepTime)
            // 启动定时器
            timer?.resume()
            timer?.setEventHandler {
                var page:NSInteger = self.pageControl!.currentPage;
                print(page)
                page+=1
                DispatchQueue.main.sync {
                    self.backScrollView?.setContentOffset(CGPoint.init(x: self.frame.size.width  * CGFloat(page + 1), y: 0), animated: false)
                }
                
                
            }
        }
        
        
        
        
    }
    
    func timerStop()
    {
        timer?.cancel()
        timer = nil
        
    }

}
extension TMSwiftBannerView
{
    func tapClick(_ tap:UITapGestureRecognizer) {
         tag = (tap.view?.tag)!
        self.delegate?.imageViewClick(tag, imageStr: self.imageArray[tag] as! String)
    }

}




extension TMSwiftBannerView:UIScrollViewDelegate
{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
        let offsetX:CGFloat = scrollView.contentOffset.x
        let currentIndex = NSInteger(offsetX/self.frame.size.width)
        if currentIndex==0 {
            
            backScrollView?.setContentOffset(CGPoint.init(x: self.frame.size.width * CGFloat(self.imageArray.count-2), y: 0), animated: false)
            pageControl?.currentPage = self.imageArray.count-3
            
            
        }else if currentIndex == self.imageArray.count-1
        {
           backScrollView?.setContentOffset(CGPoint.init(x: self.frame.size.width , y: 0), animated: false)
           pageControl?.currentPage = 0
        }else
        {
           pageControl?.currentPage = currentIndex-1
        }
        
    }
    
    //手指触摸
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.timerStop()
        
    }
    //手指离开
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        self.timerStart()
    }
}


extension TMSwiftBannerView:UIPageViewControllerDelegate
{

}
