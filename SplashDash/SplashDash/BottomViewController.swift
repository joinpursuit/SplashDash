////
////  BottomViewController.swift
////  SplashDash
////
////  Created by Sabrina Ip on 3/2/17.
////  Copyright © 2017 SHT. All rights reserved.
////
//
//import UIKit
//import ISHPullUp
//
//class BottomViewController: UIViewController, ISHPullUpSizingDelegate, ISHPullUpStateDelegate  {
//    
//    weak var delegate: ButtonDelegate?
//    weak var pullUpController: ISHPullUpViewController!
//
//    override func loadView() {
//        let testView = ISHPullUpRoundedView()
//        testView.backgroundColor = .clear
//        testView.cornerRadius = 10.0
////        testView.clipsToBounds = true
////        testView.strokeColor = .red
////        testView.strokeWidth = 5.0
//        
//        self.view = testView
//    }
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
////        let roundedVisualEffectView = ISHPullUpRoundedVisualEffectView()
////        roundedVisualEffectView.backgroundColor = .clear
//
////        self.view = roundedVisualEffectView
////        self.view.clearsContextBeforeDrawing = false
//        // TO DO: FIGURE OUT WHY CORNER IS NOT ROUNDED AFTER ADDING SUBVIEW
//        self.setupViewHierarchy()
//        self.configureConstraints()
//        
////        self.view.clipsToBounds = true
////        self.view.layer.masksToBounds = true
////        let path = UIBezierPath(roundedRect:topView.bounds,
////                                byRoundingCorners:[.topRight, .topLeft],
////                                cornerRadii: CGSize(width: 20, height:  20))
////        let maskLayer = CAShapeLayer()
////        maskLayer.path = path.cgPath
////        topView.layer.mask = maskLayer
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.view.layer.masksToBounds = true
//    }
//    
//    // MARK: ISHPullUpSizingDelegate
//    
//    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, maximumHeightForBottomViewController bottomVC: UIViewController, maximumAvailableHeight: CGFloat) -> CGFloat {
//        let totalHeight = self.view.systemLayoutSizeFitting(UILayoutFittingExpandedSize).height
//        return totalHeight
//    }
//    
//    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, minimumHeightForBottomViewController bottomVC: UIViewController) -> CGFloat {
//        return self.topView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height;
//    }
//    
//    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, targetHeightForBottomViewController bottomVC: UIViewController, fromCurrentHeight height: CGFloat) -> CGFloat {
//        
//        // SNAPS To HALFWAYPOINT
//        let halfwayPoint = self.view.frame.height/2
//        if abs(height - halfwayPoint) < 100 {
//            print("snapped to halfwayPoint")
//            return halfwayPoint
//        }
//        print("halfwayPoint: \(halfwayPoint), height: \(height)")
//        return height
//    }
//    
//    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, update edgeInsets: UIEdgeInsets, forBottomViewController bottomVC: UIViewController) {
//        // we update the scroll view's content inset
//        // to properly support scrolling in the intermediate states
////        scrollView.contentInset = edgeInsets;
//    }
//    
//    // MARK: ISHPullUpStateDelegate
//    
//    func pullUpViewController(_ pullUpViewController: ISHPullUpViewController, didChangeTo state: ISHPullUpState) {
////        topLabel.text = textForState(state);
////        handleView.setState(ISHPullUpHandleView.handleState(for: state), animated: firstAppearanceCompleted)
//    }
//    
////    private func textForState(_ state: ISHPullUpState) -> String {
////        switch state {
////        case .collapsed:
////            return "Drag up or tap"
////        case .intermediate:
////            return "Intermediate"
////        case .dragging:
////            return "Hold on"
////        case .expanded:
////            return "Drag down or tap"
////        }
////    }
//    
//    // MARK: - Button Delegate
//    
//    func startButtonTapped() {
//        delegate?.startButtonTapped()
//    }
//
//    // MARK: - Setup Views
//    
//    func setupViewHierarchy() {
//        self.view.addSubview(topView)
//        self.view.addSubview(contentView)
//        self.view.addSubview(gameButton)
//        topView.addSubview(currentRunLabel)
//        contentView.addSubview(contentCollectionView)
//    }
//    
//    func configureConstraints() {
//        currentRunLabel.snp.makeConstraints { (view) in
//            view.leading.top.bottom.equalToSuperview().inset(8.0)
//        }
//        
//        topView.snp.makeConstraints { (view) in
//            view.leading.top.trailing.equalToSuperview()
//        }
//        
//        contentCollectionView.snp.makeConstraints { (view) in
//            view.leading.top.trailing.bottom.equalToSuperview().inset(8.0)
//        }
//        
//        contentView.snp.makeConstraints { (view) in
//            view.leading.trailing.bottom.equalToSuperview()
//            view.top.equalTo(topView.snp.bottom)
//        }
//        
//        gameButton.snp.remakeConstraints { (view) in
//            view.bottom.equalTo(self.view.snp.top).inset(10)
////            view.top.equalToSuperview()
//            view.trailing.equalToSuperview().offset(-30)
//            view.size.equalTo(CGSize(width: 70, height: 70))
//        }
//        
////        findMeButton.snp.remakeConstraints { (view) in
////            view.trailing.equalTo(gameButton)
////            view.bottom.equalTo(gameButton.snp.top).offset(-40)
////            view.size.equalTo(CGSize(width: 70, height: 70))
////        }
//    }
//    
//    // MARK: - Views
//    
//    private lazy var topView: UIView = {
//        let view = UIView()
//        view.backgroundColor = SplashColor.darkPrimaryColor()
////        view.layer.cornerRadius = 5.0
////        view.clipsToBounds = true
//        return view
//    }()
//    
//    private lazy var currentRunLabel: UILabel = {
//        let label = UILabel()
//        label.text = "Duration of run: \("30 mins")\nDistance: \("2.1 miles")"
//        label.textColor = SplashColor.lightPrimaryColor()
//        label.numberOfLines = 0
//        return label
//    }()
//    
//    private lazy var contentView: UIView = {
//        let view = UIView()
//        view.backgroundColor = SplashColor.primaryColor()
//        return view
//    }()
//    
//    private lazy var contentCollectionView: ContentCollectionView = {
//        let view = ContentCollectionView()
//        return view
//    }()
//    
//    lazy var gameButton: UIButton = {
//        let button = UIButton()
//        button.setTitle("Start", for: .normal)
//        button.isEnabled = true
//        let originalSplash = UIImage(named: "logoSplash")
//        let colorableSplash = originalSplash?.withRenderingMode(.alwaysTemplate)
//        button.setBackgroundImage(colorableSplash, for: .normal)
//        button.tintColor = .blue // placeholder color
//        button.addShadows()
////        button.clipsToBounds = true
//        button.addTarget(self, action: #selector(startButtonTapped), for: .touchUpInside)
//        //        button.addTarget(self, action: #selector(updateGameStatus), for: .touchUpInside)
//        return button
//    }()
//    
//
//}
