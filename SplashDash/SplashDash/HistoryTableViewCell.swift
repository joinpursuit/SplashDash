//
//  HistoryTableViewCell.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

class HistoryTableViewCell: UITableViewCell {
    static let cellIdentifier = "History Table View Cell"
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: reuseIdentifier)
        setupHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Setup Views
    private func setupHierarchy() {
        self.addSubview(runLabel)
    }
    
    private func configureConstraints() {
        runLabel.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview().inset(8.0)
        }
    }
    
    // MARK: - Views    
    lazy var runLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
}
