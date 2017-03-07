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

    var contentViews = [UIView]()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViewHierarchy()
        self.configureConstraints()
        
        let tempView1 = UserRunHistoryView()
        tempView1.backgroundColor = SplashColor.primaryColor()
        let tempView2 = MapHistoryView()
        tempView2.backgroundColor = SplashColor.primaryColor()
//        let tempView3 = UIView()
//        tempView3.backgroundColor = SplashColor.primaryColor()
//        let tempView4 = UIView()
//        tempView4.backgroundColor = SplashColor.primaryColor()
        contentViews = [tempView1, tempView2]
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
        return CGSize(width: self.frame.size.width, height: self.frame.size.height)
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
        cv.bounces = false
        cv.isPagingEnabled = true
        cv.delegate = self
        cv.dataSource = self
//        cv.showsHorizontalScrollIndicator = false
        cv.register(ContentCollectionViewCell.self, forCellWithReuseIdentifier: ContentCollectionViewCell.identifier)
        return cv
    }()
}
