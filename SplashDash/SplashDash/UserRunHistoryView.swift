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
            self.createCellHeightsArray()
            self.userHistoryTableView.reloadData()
        }
    }
    
    var kCloseCellHeight: CGFloat {
        get{
            return self.kOpenCellHeight/3
        }
    }
    
    var kOpenCellHeight: CGFloat {
        get{
            return self.userHistoryTableView.frame.height
        }
    }
    
    var cellHeights = [CGFloat]()
    
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
            view.bottom.equalToSuperview()
        }
    }
    
//    // MARK: - Actions

    func createCellHeightsArray() {
        cellHeights = []
        for _ in 0...userRuns.count {
            cellHeights.append(kCloseCellHeight)
        }
    }
    
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
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as RunHistoryFoldingTableViewCell = cell else {
            return
        }
        
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: true, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: true, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RunHistoryFoldingTableViewCell
        
        if cell.isAnimating() {
            return
        }
        
        //(indexPath as NSIndexPath
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight {
            // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            cell.selectedAnimation(true, animated: true, completion: { (_) in
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                tableView.isScrollEnabled = false
            })
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            cell.selectedAnimation(false, animated: true, completion: { (_) in
                tableView.isScrollEnabled = true
            })
            duration = 0.8
        }
        
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.reloadData()
        }, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier, for: indexPath) as! RunHistoryFoldingTableViewCell
        
        
        cell.layer.masksToBounds = true
        cell.layer.borderWidth = 50.0
        cell.layer.cornerRadius = 15.0
        cell.layer.borderColor = UIColor.clear.cgColor
//
        //without folding cell
//        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier, for: indexPath) as! HistoryTableViewCell
//        
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
    
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.text = "HISTORY"
        label.textColor = SplashColor.lightPrimaryColor()
        return label
    }()
    
    lazy var userHistoryTableView: UITableView = {
        let tView = UITableView()
        tView.delegate = self
        tView.dataSource = self
        tView.backgroundColor = SplashColor.primaryColor()
        tView.separatorStyle = .none
        //Register folding cell to user's table view
        tView.register(UINib(nibName: "RunHistoryFoldingTableViewCell", bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
//        tView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
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
