//
//  NYTimesTC.swift
//  NYTimesapp
//
//  Created by Hardik on 25/11/18.
//  Copyright © 2018 Hardik. All rights reserved.
//

import UIKit

class NYTimesTC: UITableViewCell {
    
    @IBOutlet var viewCell: UIView!
    @IBOutlet var viewImg : UIImageView!
    @IBOutlet var imgarrow : UIImageView!
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var lblarticalby : UILabel!
    @IBOutlet var lblname : UILabel!
    @IBOutlet var lblDate : UILabel!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
