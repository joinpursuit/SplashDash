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
                userRuns = user.runs
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
        self.addSubview(historyLabel)
        self.addSubview(userHistoryTableView)
//        self.addSubview(logoutButton)
    }
    
    func configureConstraints() {
        historyLabel.snp.makeConstraints { (view) in
            view.top.equalToSuperview().offset(16.0)
            view.leading.equalToSuperview().offset(8.0)
        }
        
//        logoutButton.snp.makeConstraints { (view) in
//            view.centerX.equalToSuperview()
//            view.bottom.equalToSuperview().inset(20.0)
//            view.width.equalTo(200.0)
//        }
        
        userHistoryTableView.snp.makeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(historyLabel.snp.bottom).offset(8.0)
            view.bottom.equalToSuperview().offset(-16.0)
        }
    }
    
//    // MARK: - Actions
//    
//    func logoutButtonTapped(){
//        print("logout button tapped")
//    }
    
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
 
        cell.runLabel.text = "TimeStamp: \(run.timeStamp)\nTotal Distance: \(run.totalDistance)\nDuration: \(run.runDuration)\nAverage Speed: \(run.averageSpeed)"
        return cell
    }
 
    // MARK: - Views
    
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.text = "HISTORY"
        label.textColor = SplashColor.lightPrimaryColor()
        return label
    }()
    
    private lazy var userHistoryTableView: UITableView = {
        let tView = UITableView()
        tView.delegate = self
        tView.dataSource = self
        tView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
        tView.estimatedRowHeight = 250
        tView.rowHeight = UITableViewAutomaticDimension
        return tView
    }()
    
//    private lazy var logoutButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("LOG OUT", for: .normal)
//        button.backgroundColor = SplashColor.darkPrimaryColor()
//        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
//        return button
//    }()
}
