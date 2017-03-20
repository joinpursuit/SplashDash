//
//  MapSliderView.swift
//  SplashDash
//
//  Created by Harichandan Singh on 3/15/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit
import SnapKit

@objc protocol MapSliderViewDelegate {
    func winnerButtonTapped(_ sender: UIButton)
}

class MapSliderView: UIView, MKMapViewDelegate {
    //MARK: - Properties
    var delegate: MapSliderViewDelegate?
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setUpViewHierarchy()
        configureConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    //MARK: - Methods
    func setUpViewHierarchy() {
        self.addSubview(mapView)
        self.addSubview(sliderContainerView)
        self.addSubview(slider)
        self.addSubview(winnerButton)
    }
    
    func configureConstraints() {
        mapView.snp.makeConstraints { (view) in
            view.leading.top.trailing.equalToSuperview()
            view.bottom.equalTo(self.snp.centerY).multipliedBy(1.5)
        }
        
        sliderContainerView.snp.makeConstraints { (view) in
            view.top.equalTo(mapView.snp.bottom)
            view.leading.trailing.bottom.equalToSuperview()
        }
        
        winnerButton.snp.makeConstraints { (view) in
            view.leading.equalTo(sliderContainerView).offset(10.0)
            view.centerY.equalTo(sliderContainerView)
            view.top.equalTo(sliderContainerView).offset(10.0)
            view.bottom.equalTo(sliderContainerView).inset(10.0)
            view.width.equalTo(60)
        }
        
        slider.snp.makeConstraints { (view) in
            view.leading.equalTo(winnerButton.snp.trailing).offset(10.0)
            view.trailing.equalTo(sliderContainerView).inset(10.0)
            view.centerY.equalTo(sliderContainerView)
        }
    }
    
    //MARK: - Views
    lazy var mapView: MKMapView = {
        let view = MKMapView()
        view.mapType = .standard
        //        view.isUserInteractionEnabled = false
        view.showsScale = true
        view.showsCompass = true
        view.showsBuildings = false
        view.showsPointsOfInterest = false
        view.showsCompass = false
        
        return view
    }()
    
    lazy var sliderContainerView: UIView = {
        let view = UIView()
        view.isUserInteractionEnabled = false
        view.backgroundColor = UIColor.white
        
        return view
    }()
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.thumbTintColor = SplashColor.primaryColor()
        slider.minimumTrackTintColor = SplashColor.primaryColor()
        slider.minimumValue = 0
        slider.isContinuous = true
        
        return slider
    }()
    
    lazy var winnerButton: UIButton = {
        let button = UIButton()
        var image = UIImage(named: "logoSplash")?.withRenderingMode(.alwaysTemplate)
        var newImage = image?.imageWithColor(color1: UIColor.clear)
        button.setImage(newImage, for: .normal)
        
        return button
    }()
}
