//
//  UserRunHistoryView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import ISHPullUp
 
class UserRunHistoryView: UIView, UITableViewDelegate, UITableViewDataSource {
    
    var user: User? {
        didSet {
            guard let user = user else { return }
            userRuns = user.runs.sorted {
                return $0.timeStamp > $1.timeStamp
            }
        }
    }
    
    var userRuns: [Run] = [] {
        didSet {
            self.userHistoryTableView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupViewHierarchy() {
        self.addSubview(userHistoryTableView)
    }
    
    func configureConstraints() {
        userHistoryTableView.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: - TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userRuns.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier, for: indexPath) as! HistoryTableViewCell
        
        let run = userRuns[indexPath.row]
        
        let date = Date(timeIntervalSince1970: run.timeStamp)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .none
        let dateString = dateFormatter.string(from: date)
        
        let timeFormatter = DateFormatter()
        timeFormatter.dateStyle = .none
        timeFormatter.timeStyle = .short
        let timeString = timeFormatter.string(from: date)
        
        let miles = run.totalDistance * 0.000621371
        let distanceString = String.localizedStringWithFormat("%.2f", miles)
        
        var durationString = ""
        let hours = run.runDuration / 3600
        let minutes = (run.runDuration % 3600) / 60
        let seconds = (run.runDuration % 3600) % 60
        
        if hours > 0 {
            durationString += "\(hours)h "
        }
        if minutes > 0 {
            durationString += "\(minutes)m "
        }
        durationString += "\(seconds)s"
        
        let mph = run.averageSpeed * 2.23694
        let speedString = String.localizedStringWithFormat("%.2f", mph)
 
        cell.runLabel.text = "Date: \(dateString)\nTime: \(timeString)\nTotal Distance: \(distanceString) miles\nDuration: \(durationString)\nAverage Speed: \(speedString)"
        return cell
    }
 
    // MARK: - Views
    
    lazy var userHistoryTableView: UITableView = {
        let tView = UITableView()
        tView.delegate = self
        tView.dataSource = self
        tView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
        tView.estimatedRowHeight = 250
        tView.rowHeight = UITableViewAutomaticDimension
        return tView
    }()
}
