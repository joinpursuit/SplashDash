//
//  ContentCollectionView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/5/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit

class ContentCollectionView: UIView, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var selectedSegmentIndex = 0 {
        didSet {
            let indexPath = IndexPath(item: selectedSegmentIndex, section: 0)
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
    // didSet
    //  collectionView.scrollToItem(at: nextIndexPath, at: .centeredHorizontally, animated: true)
    var contentViews = [UIView]()
    let sideMargin: CGFloat = 8.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewHierarchy()
        self.configureConstraints()
        contentViews = [userRunHistoryView, mapHistoryView]
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Collection View Delegates
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contentViews.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCollectionViewCell.identifier, for: indexPath) as! ContentCollectionViewCell
        
        let contentView = contentViews[indexPath.item]
        
        cell.addSubview(contentView)
        
        contentView.snp.remakeConstraints{ (view) in
            view.leading.top.trailing.bottom.equalToSuperview()
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.size.width - (sideMargin * 2), height: self.frame.size.height - (sideMargin * 2))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return sideMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsetsMake(sideMargin, sideMargin, sideMargin, sideMargin)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
//        print(targetContentOffset.pointee.x)
//        print(self.frame.width)
        let currentPage = Int((targetContentOffset.pointee.x + (sideMargin*2)) / self.frame.width)
//        print("current page \(currentPage)")
        if let bottomView = self.superview as? BottomView {
            bottomView.contentSegmentedControl.selectedSegmentIndex = currentPage
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.endEditing(true)
    }
    
    // MARK: - Setup Views
    
    func setupViewHierarchy() {
        self.addSubview(collectionView)
    }
    
    func configureConstraints() {
        collectionView.snp.makeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview()
        }
    }
    
    // MARK: - Views
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = SplashColor.primaryColor()
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
//        cv.showsHorizontalScrollIndicator = false
        cv.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        return cv
    }()
    
    lazy var userRunHistoryView: UserRunHistoryView = {
        let view = UserRunHistoryView()
        view.backgroundColor = SplashColor.primaryColor()
        return view
    }()
    
    lazy var mapHistoryView: MapHistoryView = {
        let view = MapHistoryView()
        view.backgroundColor = SplashColor.primaryColor()
        
        return view
    }()
}
