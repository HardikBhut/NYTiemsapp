//
//  WebserviceHelper.swift
//  NYTimesapp
//
//  Created by Hardik on 24/11/18.
//  Copyright © 2018 Hardik. All rights reserved.
//


import UIKit
import Alamofire
import SwiftyJSON

import SystemConfiguration

class WebServiceHelper: NSObject {
    
    typealias SuccessHandler = (JSON) -> Void
    typealias FailureHandler = (Error) -> Void
    typealias FailureHandler1 = (String) -> Void
    
    
    // MARK: - Internet Connectivity
    
    class func isConnectedToNetwork() -> Bool {
        
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout<sockaddr_in>.size)
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }
        
        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }
        
        let isReachable = flags.contains(.reachable)
        let needsConnection = flags.contains(.connectionRequired)
        
        return (isReachable && !needsConnection)
    }
    
    // MARK: - Helper Methods
    
    class func getWebServiceCall(_ strURL : String, isShowLoader : Bool, success : @escaping SuccessHandler, failure : @escaping FailureHandler)
    {
        if isConnectedToNetwork() {
            
            ////print(strURL)
            
            if isShowLoader == true {
                
                //For show loader
                AppDelegate.showHUD()
                
            }
            
            Alamofire.request(strURL).responseJSON { (resObj) -> Void in
                
                print(resObj)
                
                if resObj.result.isSuccess {
                    let resJson = JSON(resObj.result.value!)
                    
                    if isShowLoader == true {
                       
                        //For show loader dismiss
                        AppDelegate.hideHUD()
                        
                    }
                    
                    debugPrint(resJson)
                    success(resJson)
                    //AppDelegate.hideHUD()
                }
                if resObj.result.isFailure {
                    let error : Error = resObj.result.error!
                    
                    if isShowLoader == true {
                        
                        //For show loader dismiss
                        AppDelegate.hideHUD()
                    }
                    debugPrint(error)
                    failure(error)
                }
            }
        }else {
            
            Helper.globalAlert(msg: "NoInternet Connection!")
            AppDelegate.hideHUD()
        }
    }
    
    class func postWebServiceCall1(_ strURL : String, params : [String : AnyObject]?, isShowLoader : Bool, success : @escaping SuccessHandler, failure :@escaping FailureHandler)
    {
        if isConnectedToNetwork()
        {
            if isShowLoader == true
            {
                 AppDelegate.showHUD()
                
            }
            
            let headers : HTTPHeaders = [
                "Accept":"application/xml",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
            
            
            Alamofire.request(strURL, method:.post, parameters: params , encoding: CustomPostEncoding(), headers: headers ).responseJSON(completionHandler: {(resObj) -> Void in
                
                print(resObj)
             
          
                
                if resObj.result.isSuccess
                {
                    let resJson = JSON(resObj.result.value!)
                    
                    if isShowLoader == true
                    {
                        //For show loader dismiss
                        AppDelegate.hideHUD()
                    }
                    
                    success(resJson)
                }
                
                if resObj.result.isFailure
                {
                    let error : Error = resObj.result.error!
                    
                    if isShowLoader == true
                    {
                        //For show loader dismiss
                        AppDelegate.hideHUD()
                    }
                    
                    failure(error)
                    print(error.localizedDescription)
                    Helper.globalAlert(msg: error.localizedDescription)
                    AppDelegate.hideHUD()
                    
                }
            })
        }else {
            Helper.globalAlert(msg: "NoInternet Connection!")
            AppDelegate.hideHUD()
        }
    }
    
    class func postWebServiceCallXML(_ strURL : String, params : [String : AnyObject]?, isShowLoader : Bool, success : @escaping SuccessHandler, failure :@escaping FailureHandler)
    {
        if isConnectedToNetwork()
        {
            if isShowLoader == true
            {
                AppDelegate.showHUD()
                
            }
            
            let headers : HTTPHeaders = [
                "Accept":"application/xml",
                "Content-Type":"application/x-www-form-urlencoded"
            ]
            
            

            Alamofire.request(strURL, method:.post, parameters: params , encoding: CustomPostEncoding(), headers: headers ).responseData(completionHandler:{(resObj) -> Void in
        
                
                print(resObj)
                

           
                
            })
        }else {
            Helper.globalAlert(msg: "NoInternet Connection!")
            AppDelegate.hideHUD()
        }
    }

}


struct CustomGetEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        request.url = URL(string: request.url!.absoluteString.replacingOccurrences(of: "%5B%5D=", with: "="))
        return request
    }
}

struct CustomPostEncoding: ParameterEncoding {
    func encode(_ urlRequest: URLRequestConvertible, with parameters: Parameters?) throws -> URLRequest {
        var request = try URLEncoding().encode(urlRequest, with: parameters)
        let httpBody = NSString(data: request.httpBody!, encoding: String.Encoding.utf8.rawValue)!
        request.httpBody = httpBody.replacingOccurrences(of: "%5B%5D=", with: "=").data(using: .utf8)
        return request
    }
}





