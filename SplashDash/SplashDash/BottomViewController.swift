//
//  BottomViewController.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/2/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import ISHPullUp

class BottomViewController: UIViewController, ISHPullUpSizingDelegate, ISHPullUpStateDelegate  {
    
    weak var pullUpController: ISHPullUpViewController!

    override func viewDidLoad() {
        super.viewDidLoad()
        let roundedVisualEffectView = ISHPullUpRoundedVisualEffectView()
        roundedVisualEffectView.backgroundColor = .clear
        self.view = roundedVisualEffectView
        self.view.clearsContextBeforeDrawing = false
        // TO DO: FIGURE OUT WHY CORNER IS NOT ROUNDED AFTER ADDING SUBVIEW
        self.setupViewHierarchy()
        self.configureConstraints()
        
//        let path = UIBezierPath(roundedRect:topView.bounds,
//                                byRoundingCorners:[.topRight, .topLeft],
//                                cornerRadii: CGSize(width: 20, height:  20))
//        let maskLayer = CAShapeLayer()
//        maskLayer.path = path.cgPath
//        topView.layer.mask = maskLayer
    }
    
    // MARK: ISHPullUpSizingDelegate
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
        let totalHeight = self.view.systemLayoutSizeFitting(UILayoutFittingExpandedSize).height
        return totalHeight
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
        return self.topView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height;
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
        
        // SNAPS To HALFWAYPOINT
        let halfwayPoint = self.view.frame.height/2
        if abs(height - halfwayPoint) < 100 {
            print("snapped to halfwayPoint")
            return halfwayPoint
        }
        print("halfwayPoint: \(halfwayPoint), height: \(height)")
        return height
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController bottomVC: UIViewController) {
        // we update the scroll view's content inset
        // to properly support scrolling in the intermediate states
//        scrollView.contentInset = edgeInsets;
    }
    
    // MARK: ISHPullUpStateDelegate
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
//        topLabel.text = textForState(state);
//        handleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
    }
    
//    private func textForState(_ state: ISHPullUpState) -> String {
//        switch state {
//        case .collapsed:
//            return "Drag up or tap"
//        case .intermediate:
//            return "Intermediate"
//        case .dragging:
//            return "Hold on"
//        case .expanded:
//            return "Drag down or tap"
//        }
//    }

    // MARK: - Setup Views
    
    func setupViewHierarchy() {
        self.view.addSubview(topView)
        self.view.addSubview(contentView)
        topView.addSubview(currentRunLabel)
        contentView.addSubview(contentCollectionView)
    }
    
    func configureConstraints() {
        currentRunLabel.snp.makeConstraints { (view) in
            view.leading.top.bottom.equalToSuperview().inset(8.0)
        }
        
        topView.snp.makeConstraints { (view) in
            view.leading.top.trailing.equalToSuperview()
        }

        
        contentCollectionView.snp.makeConstraints { (view) in
            view.leading.top.trailing.bottom.equalToSuperview().inset(8.0)
        }
        
        contentView.snp.makeConstraints { (view) in
            view.leading.trailing.bottom.equalToSuperview()
            view.top.equalTo(topView.snp.bottom)
        }
    }
    
    // MARK: - Views
    
    private lazy var topView: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.darkPrimaryColor()
        return view
    }()
    
    private lazy var currentRunLabel: UILabel = {
        let label = UILabel()
        label.text = "Duration of run: \("30 mins")\nDistance: \("2.1 miles")"
        label.textColor = SplashColor.lightPrimaryColor()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = SplashColor.primaryColor()
        return view
    }()
    
    private lazy var contentCollectionView: ContentCollectionView = {
        let view = ContentCollectionView()
        return view
    }()

}
