//
//  StudentCell.swift
//  LetterWritingCheker
//
//  Created by Emma Gannon on 14/03/2016.
//  Copyright © 2016 Emma Gannon. All rights reserved.
//

import UIKit

class StudentCell: UITableViewCell {
    

    @IBOutlet weak var lblContent: UILabel!
    @IBOutlet weak var DeleteButton: UIButton!
    
    @IBOutlet weak var sMark: UILabel!
    @IBOutlet weak var aMark: UILabel!
    @IBOutlet weak var pMark: UILabel!
    @IBOutlet weak var nMark: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
  
}
