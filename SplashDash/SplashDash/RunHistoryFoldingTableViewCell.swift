//
//  RunHistoryFoldingTableViewCell.swift
//  SplashDash
//
//  Created by Tong Lin on 3/15/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import FoldingCell
import SnapKit

class RunHistoryFoldingTableViewCell: FoldingCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.foregroundView.addSubview(runLabel)
        runLabel.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview().inset(5.0)
        }
        
        self.itemCount = 3
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.33, 0.26, 0.19, 0.12] // timing animation for each view
        return durations[itemIndex]
    }
    
    // MARK: - Views
    lazy var runLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

}
