//
//  ViewController.swift
//  NYTimesapp
//
//  Created by Hardik on 24/11/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import UIKit

class NYTimesListVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var viewTop: UIView!
    @IBOutlet var viewHeader : UIView!
    @IBOutlet var viewBody : UIView!
    @IBOutlet var tblPopularlist : UITableView!
    var arrpopularlist = NSMutableArray()
    @IBOutlet var btnRefresh : UIButton!
    var Index = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
      GetMostpopularData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(true)
        self.setColor()
        
    }
    
    // MARK: ===================== Initial Method ========================== //
    
    func setColor()   {
        
        viewTop.backgroundColor = kgreen_color
        viewHeader.backgroundColor = kgreen_color
        viewBody.backgroundColor = kWhite_Color
        btnRefresh.imageWith(color: kWhite_Color, for: .normal)
       
        
    }
    
    // MARK: ===================== Button Method ========================== //
    
    @IBAction func btnRefresh(_ sender: Any) {
        
        GetMostpopularData()
       
    }
    
    // MARK: ===================== Table Method ========================== //
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.arrpopularlist.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat
    {
       
            return 125
        
    }

     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NYTimesTC") as! NYTimesTC
        
        
        cell.viewCell.layer.masksToBounds = true
        cell.viewCell.layer.cornerRadius = 5
        
        cell.viewCell.backgroundColor = kBackGround_Color
        cell.lblTitle.textColor = kTitle_Color
        cell.lblarticalby.textColor = ksubTitle_color
        cell.lblDate.textColor = ksubTitle_color
        cell.lblname.textColor = ksubTitle_color
        cell.lblname.textColor = ksubTitle_color
        cell.viewImg.backgroundColor = kimg_color
       
        
        cell.viewImg.backgroundColor = kimg_color
        cell.viewImg.layer.masksToBounds = true
        cell.viewImg.layer.cornerRadius = 25
        cell.imgarrow.maskWith(color: kimg_color)
        
        
         cell.lblTitle.text = Helper.checkNull(value: (self.arrpopularlist.object(at: (indexPath.row)) as! NSDictionary).value(forKey: "title") as? String as AnyObject)
         cell.lblarticalby.text = Helper.checkNull(value: (self.arrpopularlist.object(at: (indexPath.row)) as! NSDictionary).value(forKey: "byline") as? String as AnyObject)
        cell.lblname.text = Helper.checkNull(value: (self.arrpopularlist.object(at: (indexPath.row)) as! NSDictionary).value(forKey: "source") as? String as AnyObject)
        
        let strdate = Helper.checkNull(value: (self.arrpopularlist.object(at: (indexPath.row)) as! NSDictionary).value(forKey: "published_date") as? String as AnyObject)
        let attributedString = NSMutableAttributedString(string: " ")
        let attachment = NSTextAttachment()
        let iconsSize = CGRect(x: -3, y: -3, width: 20, height: 20)
        attachment.image =  UIImage(named: "ic_calender")
        attachment.bounds = iconsSize
        attributedString.append(NSAttributedString(attachment: attachment))
        attributedString.append(NSAttributedString(string: strdate))
        cell.lblDate.attributedText = attributedString
        
        let arrimg = (self.arrpopularlist.object(at: (indexPath.row)) as! NSDictionary).value(forKey: "media") as? NSArray
       // print(arrimg!)
        let arrmedia  = (arrimg!.object(at: (0)) as! NSDictionary).value(forKey: "media-metadata") as? NSArray
         print(arrmedia!)
        let urlstring = Helper.checkNull(value: (arrmedia?.object(at: (1)) as! NSDictionary).value(forKey: "url") as? String as AnyObject)
        print(urlstring)
        cell.viewImg.image = UIImage(named: "placeholder")
        cell.viewImg.downloadImageFrom(link: urlstring, contentMode: UIView.ContentMode.scaleAspectFit)
        
        
        
         return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.Index = indexPath.row
        self.performSegue(withIdentifier: "segueDetails", sender: self)
    }
    
    // MARK: ===================== SegueDelegate Method ========================== //
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        
        if (segue.identifier == "segueDetails")
        {
            let nextScene =  segue.destination as! NYTimesDetailsVC
            nextScene.arrMostPopularlist = self.arrpopularlist
            nextScene.indexList = self.Index
        }
    }
    
     // MARK: ===================== WebService Method ========================== //
    
    func GetMostpopularData()
    {
        
       // Helper.SHOWHUD(view: self.view)
        WebServiceHelper.getWebServiceCall(BASE_URL, isShowLoader: true, success:
            { (responceObj) in
                
                print(responceObj)
                let arrData = responceObj["results"].arrayObject! as NSArray
                if(arrData.count != 0)
                {
                    self.arrpopularlist = arrData.mutableCopy() as! NSMutableArray
                    self.tblPopularlist.reloadData()
                    Helper.HIDEHUD(view: self.view)
                    let indexPath = IndexPath(row: 0, section: 0)
                    self.tblPopularlist.scrollToRow(at: indexPath, at: .top, animated: true)
                }
        }, failure:
            { (error) in
                
                Helper.HIDEHUD(view: self.view)
        })
    }

}

extension UIImageView {
    func downloadImageFrom(link:String, contentMode: UIView.ContentMode) {
        URLSession.shared.dataTask( with: NSURL(string:link)! as URL, completionHandler: {
            (data, response, error) -> Void in
            DispatchQueue.main.async {
                self.contentMode =  contentMode
                if let data = data { self.image = UIImage(data: data) }
            }
        }).resume()
    }
}

