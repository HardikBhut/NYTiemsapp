//
//  NYTimesDetailsVC.swift
//  NYTimesapp
//
//  Created by Hardik on 25/11/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import UIKit
import WebKit

class NYTimesDetailsVC: UIViewController,WKNavigationDelegate {
    
    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewHeader : UIView!
    @IBOutlet var viewBody : UIView!
    @IBOutlet var btnBack : UIButton!
    var arrMostPopularlist = NSMutableArray()
    var webView: WKWebView?
    var indexList = Int()
    
   
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.setColor()
        self.GetPopularData()
        
    }
    // MARK: ===================== Initial Method ========================== //
    
    func setColor()   {
        
        viewTop.backgroundColor = kgreen_color
        viewHeader.backgroundColor = kgreen_color
        viewBody.backgroundColor = kWhite_Color
        btnBack.imageWith(color: kWhite_Color, for: .normal)
       
    }
    
    // MARK: ===================== Button Method ========================== //
    
    @IBAction func btnBack(_ sender: Any) {
        
         self.navigationController?.popViewController(animated: true)
    }
    
      // MARK: ===================== Popuplar Get Data Method ========================== //
    
    func GetPopularData()  {
        
        let myStories = Helper.checkNull(value: (self.arrMostPopularlist.object(at: (indexList)) as! NSDictionary).value(forKey: "url") as? String as AnyObject)
        let url = NSURL(string: myStories)
        let request = NSURLRequest(url: url! as URL)
        
      
        webView = WKWebView(frame: self.view.frame)
        webView?.navigationDelegate = self
        webView!.load(request as URLRequest)
        self.viewBody.addSubview(webView!)
        self.viewBody.sendSubviewToBack(webView!)
        
    }
    
      // MARK: ===================== WebView Delegate Method ========================== //
    
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        print(error.localizedDescription)
    }
    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        print("Strat to load")
        
      //  Helper.SHOWHUD(view: self.view)
    }
    private func webView(webView: WKWebView, didFinishNavigation navigation: WKNavigation!) {
        print("finish to load")
      // Helper.HIDEHUD(view: self.view)
    }
    
   
    
}
