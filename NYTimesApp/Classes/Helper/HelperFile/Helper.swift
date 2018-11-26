 //
//  Helper.swift
 //  Appointments
 //
 //  Created by Hardik on 09/10/18.
 //  Copyright © 2018 Hardik. All rights reserved.
 
 //
import UIKit
import Foundation

class Helper: NSObject {

    
    // MARK: ===================== GLOBAL ALERT ========================== //
    class func globalAlert(msg: String) {
        let alertView:UIAlertView = UIAlertView()
        alertView.title = "Appointment"
        alertView.message = msg
        alertView.delegate = self
        alertView.addButton(withTitle: "OK")
        
        alertView.show()
    }
    
    // MARK: ===================== TEXT FIELD BORDER METHOD ========================== //
    class func attributedTextField(txtField: UITextField) {
        // let textField = UITextField(frame: frame)
        
        let borderUsername = CALayer()
        let widthUsername = CGFloat(1.0)
        borderUsername.borderColor = UIColor.darkGray.cgColor
        borderUsername.frame = CGRect(x: 0, y: txtField.frame.size.height - widthUsername, width:  txtField.frame.size.width, height: txtField.frame.size.height)
        
        borderUsername.borderWidth = widthUsername
        txtField.layer.addSublayer(borderUsername)
        txtField.layer.masksToBounds = true
        //return txtField
    }
    


    // MARK: ================= Compile Blank String Method ================= //
    class func isBlank (String :String?) -> Bool {
        
        if let string = String {
            return string.isEmpty
        } else {
            
            return true
        }
    }
    
    // MARK: ===================== SET / GET :- STRING ========================== //
    class func setPREF(sValue: String, skye:String) {
        
        UserDefaults.standard.setValue(sValue, forKey: skye)
        UserDefaults.standard.synchronize()
    }
    class func getPREF(skey: String) ->  String {
        return  UserDefaults.standard.value(forKey: skey) as! String
    }
    
    // MARK: ===================== SET / GET :- INTEGER ========================== //
    class func setPREFint(sValue: Int, skye:String) {
        
        UserDefaults.standard.setValue(sValue, forKey: skye
        )
        UserDefaults.standard.synchronize()
    }
    class func getPREFint(skey: String) ->  Int {
        return UserDefaults.standard.integer(forKey:skey)
    }
    
    // MARK: ===================== SET / GET :- NS_MUTABLE_ARRAY ========================== //
    class func setPREFArrayNSMutable(sValue: NSMutableArray, skye:String) {
        
        UserDefaults.standard.setValue(sValue, forKey: skye)
        UserDefaults.standard.synchronize()
    }
    class func getPREFArrayNSMutable(skey: String) ->  NSMutableArray {
        return UserDefaults.standard.mutableArrayValue(forKey:skey)
    }
    
    // MARK: ===================== SET / GET :-  NS_ARRAY ========================== //
    class func setPREFArray(sValue: NSArray, skye:String) {
        
        UserDefaults.standard.setValue(sValue, forKey: skye)
        UserDefaults.standard.synchronize()
    }
    class func getPREFArray(skey: String) ->  NSArray {
        return UserDefaults.standard.mutableArrayValue(forKey:skey)
    }
    
    // MARK: ===================== SET / GET :-  NS_DICTIONARY ========================== //
    class func setDic(sValue: NSDictionary, sKye:String){
        
        UserDefaults.standard.setValue(sValue, forKey: sKye)
        UserDefaults.standard.synchronize()
    }
    class func getDic(skey: String) ->  NSDictionary {
        //return UserDefaults.standard.dictionaryWithValues(forKeys: [skey]) as NSDictionary
        return (UserDefaults.standard.dictionary(forKey: skey) as NSDictionary?)!
    }
    
     // MARK: ===================== SET / GET :-  Data ========================== //
    class func setData(sValue: NSData, sKye:String){
        
        UserDefaults.standard.setValue(sValue, forKey: sKye)
        UserDefaults.standard.synchronize()
    }
    class func getData(skey: String) ->  NSData {
       
        return UserDefaults.standard.data(forKey: skey)! as NSData
    }
    

    
    // MARK: ===================== MB_PROGRESS_HUDE ========================== //
    class func showHUD(to_view: UIView) {
        let hud = MBProgressHUD.showAdded(to: to_view, animated: true)
        hud?.dimBackground = true
    }
    
    class func hideHUD(for_view: UIView) {
        MBProgressHUD.hideAllHUDs(for: for_view, animated: true)
    }
    
    class func showHUD() {
        AppDelegate.showHUD()
    }
    
    class func hideHUD() {
        AppDelegate.hideHUD()
    }
    
    //====
    
    class func SHOWHUD(view: UIView)
    {
        let hud = MBProgressHUD.showAdded(to: view, animated: true)
        hud?.dimBackground = true
    }
    class func HIDEHUD(view: UIView)
    {
        MBProgressHUD.hideAllHUDs(for: view, animated: true)
    }
    

    // MARK: ===================== CHECK HELPER VALUE IS BLANK OR NOT ========================== //
    class func userAlreadyExist(kUsernameKey: String) -> Bool {
        return UserDefaults.standard.object(forKey: kUsernameKey) != nil
    }
    
     // MARK: ===================== Alert Method ========================== //

    class func AlertMessage(title:String, message:String) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let cancelAction = UIAlertAction(title: "OK",
                                         style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        UIApplication.shared.keyWindow?.rootViewController!.present(alert, animated: true, completion: nil)
    }
    
    // MARK: ===================== Check Null Value  ========================== //
    
    class func checkNull(value : AnyObject?) -> String {
        if value is NSNull {
            
            return ""
            
        } else {
            return value as! String
        }
    }
    
    class func getNSDataTonsArray(datadic: Data) -> NSArray
    {
        let arrData =  NSKeyedUnarchiver.unarchiveObject(with: datadic) as! NSArray
        return arrData
    }
}

// MARK: ===================== HIDE KEYBOARD ========================== //
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

// MARK: ===================== NAVIGATE PERTICULLER VIEW CONTROLLER ========================== //
extension UINavigationController {
    
    func backToViewController(viewController: Swift.AnyClass) {
        
        for element in viewControllers as Array {
            if element.isKind(of: viewController) {
                self.popToViewController(element, animated: true)
                break
            }
        }
    }
}

// MARK: ================ DATE TO DAY CONVERT EXTENSION ======================= //





extension UITextField {
    
    override open func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        if action == #selector(copy(_:)) || action == #selector(paste(_:)) || action == #selector(selectAll(_:)) || action == #selector(delete(_:))||action == #selector(select(_:)) {
            return false
        }

        return false
    }
    
    
}

