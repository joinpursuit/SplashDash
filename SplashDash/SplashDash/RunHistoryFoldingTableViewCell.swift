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
            view.leading.trailing.top.bottom.equalToSuperview().inset(10.0)
        }
        
        self.itemCount = 3
        self.backgroundColor = .clear
        self.layer.borderWidth = 5
        self.layer.borderColor = SplashColor.primaryColor().cgColor
        self.layer.cornerRadius = 10
        self.layer.masksToBounds = true
//        self.foregroundView.layer.borderWidth = 5
//        self.foregroundView.layer.borderColor = SplashColor.primaryColor().cgColor
//        self.foregroundView.layer.cornerRadius = 10
//        
//        self.containerView.layer.borderWidth = 5
//        self.containerView.layer.borderColor = SplashColor.primaryColor().cgColor
//        self.containerView.layer.cornerRadius = 10
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: animated)

        // Configure the view for the selected state
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type: FoldingCell.AnimationType) -> TimeInterval {
        // durations count equal it itemCount
        let durations = [0.2, 0.15, 0.15, 0.12] // timing animation for each view
        return durations[itemIndex]
    }
    
    // MARK: - Views
    lazy var runLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()

}
