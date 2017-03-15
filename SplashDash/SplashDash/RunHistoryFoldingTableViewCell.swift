//
//  RunHistoryFoldingTableViewCell.swift
//  SplashDash
//
//  Created by Tong Lin on 3/15/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import FoldingCell

class RunHistoryFoldingTableViewCell: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.itemCount = 4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.26, 0.26, 0.33] // timing animation for each view
        return durations[itemIndex]
    }
}
