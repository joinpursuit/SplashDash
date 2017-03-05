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
    var uiv: UserInfoView!

    override func viewDidLoad() {
        super.viewDidLoad()
        uiv = UserInfoView()
        view.addSubview(uiv)
        
        uiv.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview()
        }
    }
    
    // MARK: ISHPullUpSizingDelegate
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
//        let totalHeight = self.view.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height
        let totalHeight = self.view.systemLayoutSizeFitting(UILayoutFittingExpandedSize).height
        return totalHeight
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {

        return uiv.topView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height;
    }
    
    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
        
        // SNAPS To HALFWAYPOINT
        let halfwayPoint = self.view.frame.height/2
        print("the halfwaypoint is \(halfwayPoint)")
        if abs(height - halfwayPoint) < 150 {
            print("halfwaypoint : \(halfwayPoint)")
            return halfwayPoint
        }
        print("height: \(height)")
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
    
    private func textForState(_ state: ISHPullUpState) -> String {
        switch state {
        case .collapsed:
            return "Drag up or tap"
        case .intermediate:
            return "Intermediate"
        case .dragging:
            return "Hold on"
        case .expanded:
            return "Drag down or tap"
        }
    }

}
