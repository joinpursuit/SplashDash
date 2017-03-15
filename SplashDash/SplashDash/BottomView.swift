//
//  BottomView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/6/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class BottomView: UIView {

    var currentUser: User?
    let topViewSpacing: CGFloat = 100.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Actions
    
    func segmentSelected(sender:ScrollableSegmentedControl) {
//        print("Segment at index \(sender.selectedSegmentIndex)  selected")
        contentCollectionView.selectedSegmentIndex = sender.selectedSegmentIndex
    }
    
    // MARK: - Setup
    
    func setupViewHierarchy() {
        self.addSubview(topView)
        self.addSubview(contentSegmentedControl)
        self.addSubview(contentCollectionView)
        self.addSubview(seperatorLine1)
//        self.addSubview(seperatorLine2)
        
        topView.addSubview(currentRunLabelContainer)
        currentRunLabelContainer.addSubview(durationLabel)
        currentRunLabelContainer.addSubview(distanceLabel)
        currentRunLabelContainer.addSubview(hoursLeftLabel)

    }
    
    func configureConstraints() {
        
        durationLabel.snp.makeConstraints { (view) in
            view.leading.top.equalToSuperview().inset(8.0)
        }
        
        distanceLabel.snp.makeConstraints { (view) in
            view.leading.equalToSuperview().inset(8.0)
            view.top.equalTo(durationLabel.snp.bottom).offset(8.0)
        }
        
        hoursLeftLabel.snp.makeConstraints { (view) in
            view.leading.bottom.equalToSuperview().inset(8.0)
            view.top.equalTo(distanceLabel.snp.bottom).offset(8.0)
        }
        
        currentRunLabelContainer.snp.makeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview().inset(8.0)
        }
        
        topView.snp.makeConstraints { (view) in
            view.leading.top.trailing.equalToSuperview()
//            view.height.equalTo(self.topViewSpacing)
        }
        
        seperatorLine1.snp.makeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(topView.snp.bottom)
            view.height.equalTo(1.0)
        }
        
        contentSegmentedControl.snp.makeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(topView.snp.bottom)
            view.height.equalTo(44.0)
        }
        
//        seperatorLine2.snp.makeConstraints { (view) in
//            view.leading.trailing.equalToSuperview()
//            view.top.equalTo(contentSegmentedControl.snp.bottom)
//            view.height.equalTo(1.0)
//        }
        
        contentCollectionView.snp.makeConstraints { (view) in
                        view.leading.trailing.bottom.equalToSuperview()
                        view.top.equalTo(contentSegmentedControl.snp.bottom)
        }
    }
    
    // MARK: - Views
    
    lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.primaryColor()
        return view
    }()
    
    private lazy var seperatorLine1: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.lightPrimaryColor()
        return view
    }()
    
    lazy var contentSegmentedControl: ScrollableSegmentedControl = {
        let control = ScrollableSegmentedControl()
        control.segmentStyle = .textOnly
        control.insertSegment(withTitle: "MY ACTIVITY", at: 0)
        control.insertSegment(withTitle: "ALL ACTIVITY", at: 1)
        control.underlineSelected = true
        control.addTarget(self, action: #selector(self.segmentSelected(sender:)), for: .valueChanged)
        //Use color manager to determine color scheme here
        control.tintColor = UIColor.white
        control.backgroundColor = SplashColor.primaryColor()
        control.selectedSegmentIndex = 0
        return control
    }()
    
    private lazy var seperatorLine2: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.lightPrimaryColor()
        return view
    }()
    
    lazy var currentRunLabelContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    lazy var durationLabel: UILabel = {
        let label = UILabel()
        var labelText = "Duration of run: 0"
        label.text = labelText
        label.textColor = SplashColor.lightPrimaryColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var distanceLabel: UILabel = {
        let label = UILabel()
        var labelText = "Distance: 0"
        label.text = labelText
        label.textColor = SplashColor.lightPrimaryColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var hoursLeftLabel: UILabel = {
        let label = UILabel()
        var labelText = ""
        label.text = labelText
        label.textColor = SplashColor.lightPrimaryColor()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var contentCollectionView: ContentCollectionView = {
        let view = ContentCollectionView()
        return view
    }()
}
