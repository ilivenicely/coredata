//
//  HighScoreCell.swift
//  McCormickRobert_CE07
//
//  Created by Robert  McCormick on 26/01/2018.
//  Copyright © 2018 Robert  McCormick. All rights reserved.
//

import UIKit

class HighScoreCell: UITableViewCell {
    @IBOutlet weak var playerLabel: UILabel!
    @IBOutlet weak var timeToCompleteLabel: UILabel!
    @IBOutlet weak var numberOfTurnsLabel: UILabel!
    @IBOutlet weak var timeStamp: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

