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
    
    var singleRunMap = SingleRunMapView()
    
    var user: User? {
        didSet {
            self.createCellHeightsArray()
            self.userHistoryTableView.reloadData()
        }
    }
    
    var kCloseCellHeight: CGFloat = 149
    
    var kOpenCellHeight: CGFloat = 447
    
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
        self.addSubview(userHistoryTableView)
    }
    
    func configureConstraints() {
        userHistoryTableView.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
//    // MARK: - Actions

    func createCellHeightsArray() {
        cellHeights = []
        for _ in 0...user!.runs.count {
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
        if let current = user{
            return current.runs.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as RunHistoryFoldingTableViewCell = cell else {
            return
        }
        
        if cellHeights[(indexPath as NSIndexPath).row] == kCloseCellHeight {
            cell.selectedAnimation(false, animated: false, completion:nil)
        } else {
            cell.selectedAnimation(true, animated: false, completion: nil)
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! RunHistoryFoldingTableViewCell
        
        if cell.isAnimating() { return }
        
        //(indexPath as NSIndexPath
        var duration = 0.0
        if cellHeights[indexPath.row] == kCloseCellHeight {
            // open cell
            cellHeights[indexPath.row] = kOpenCellHeight
            tableView.isScrollEnabled = false
            
            cell.selectedAnimation(true, animated: true, completion: { (_) in
                tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                //add map to cell
                cell.containerView.addSubview(self.singleRunMap)
                self.singleRunMap.snp.makeConstraints({ (view) in
                    view.top.bottom.leading.trailing.equalToSuperview()
                })
                
                self.singleRunMap.zoomingMap(fit: self.user!.runs[indexPath.row].allCoordinates.map{ SplashOverlay(coor: $0) })
            })
            duration = 0.5
        } else {// close cell
            cellHeights[indexPath.row] = kCloseCellHeight
            tableView.isScrollEnabled = true
            cell.selectedAnimation(false, animated: true, completion: { (_) in
                self.singleRunMap.mapDeconstruction()
                self.singleRunMap.removeFromSuperview()
            })
            duration = 0.5
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
        }, completion: nil)
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier, for: indexPath) as! RunHistoryFoldingTableViewCell
        
        
        let run = user!.runs[indexPath.row]
        
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
        tView.backgroundColor = SplashColor.primaryColor()
        tView.separatorStyle = .none
        //Register folding cell to user's table view
        tView.register(UINib(nibName: "RunHistoryFoldingTableViewCell", bundle: nil), forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
//        tView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
        tView.estimatedRowHeight = 250
        tView.rowHeight = UITableViewAutomaticDimension
        return tView
    }()
}
