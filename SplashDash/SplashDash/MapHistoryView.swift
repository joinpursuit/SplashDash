//
//  MapHistoryView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/5/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import MapKit
import Firebase
import SnapKit

class MapHistoryView: UIView, MKMapViewDelegate, MapSliderViewDelegate {
    //MARK: - Properties
    var regionCalculations: (minLat: CLLocationDegrees, minLong: CLLocationDegrees, maxLat: CLLocationDegrees, maxLong: CLLocationDegrees)!
    var datePickerDate: String!
    var databaseReference: FIRDatabaseReference!
    var splashOverlays: [SplashOverlay] = [] {
        didSet {
            self.mapSliderView.slider.maximumValue = Float(self.splashOverlays.count - 1)
        }
    }
    var lastSliderValue: Float = 0
    var myTimer: Timer?
    var scoreForDate: [(String, Float)] = [] {
        didSet {
            self.fillInWinnerButton()
        }
    }
    var winnerImage: UIImage?
    
    let calendar: Calendar = Calendar.current
    
    //MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViewHierarchy()
        configureConstraints()
        setUpMapViewLocation()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Actions
    func datePickerChanged(_ sender: UIDatePicker) {
        if myTimer != nil {
            myTimer!.invalidate()
            myTimer = nil
        }
        
        let selectedDate = self.datePicker.date
        self.datePickerDate = returnFormattedDate(date: selectedDate)
        
        if let date = self.datePickerDate {
            fetchSplashForPickerDate(date: date)
        }
    }
    
    func returnFormattedDate(date: Date) -> String {
        //Formatting date string
        let format = DateFormatter()
        format.dateFormat = "yyyyMMdd"
        
        return format.string(from: date)
    }
    
    func sliderValueChanged(sender: UISlider) {
        self.lastSliderValue = sender.value
    }
    
    func sliderMoving(sender: UISlider) {
        switch sender {
        case _ where Int(sender.value) > Int(self.lastSliderValue):
            self.mapSliderView.mapView.addOverlays([self.splashOverlays[Int(sender.value)]])
        case _ where Int(sender.value) < Int(self.lastSliderValue):
            self.mapSliderView.mapView.removeOverlays([self.splashOverlays[Int(sender.value)]])
        case _ where Int(self.lastSliderValue) == self.splashOverlays.count - 1:
               self.mapSliderView.mapView.addOverlays(self.splashOverlays)
        case _ where self.lastSliderValue == 0:
            self.mapSliderView.mapView.removeOverlays(self.splashOverlays)
            default:
            return
        }
    }
    
    //MARK: - MapSliderViewDelegate
    func winnerButtonTapped(_ sender: UIButton) {
        print("BUTTON TAPPED")
        setSliderValue()
    }
    
    func setSliderValue(){
        myTimer = Timer.scheduledTimer(timeInterval: 0.04, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
        myTimer?.fire()
    }
    
    func timerAction(){
        let increment:Float = 1
        let newval = self.mapSliderView.slider.value + increment
        
        self.mapSliderView.slider.setValue(newval, animated: true)
        
        if splashOverlays.count > 0 {
        self.mapSliderView.mapView.addOverlays([self.splashOverlays[Int(self.mapSliderView.slider.value)]])
        }
    }

    //MARK: - Setup Views
    func setupViewHierarchy() {
        self.addSubview(mapSliderView)
        mapSliderView.delegate = self
        
        self.addSubview(datePicker)
        self.addSubview(monthUpCaretLabel)
        self.addSubview(monthDownCaretLabel)
        self.addSubview(dateUpCaretLabel)
        self.addSubview(dateDownCaretLabel)
        self.addSubview(yearUpCaretLabel)
        self.addSubview(yearDownCaretLabel)
    }
    
    func configureConstraints() {
        monthUpCaretLabel.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(0.45)
            view.top.equalToSuperview()
            view.bottom.equalTo(datePicker.snp.top).offset(8.0)
        }
        
        monthDownCaretLabel.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(0.45)
            view.top.equalTo(datePicker.snp.bottom).inset(8.0)
        }
        
        dateUpCaretLabel.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(1.13)
            view.top.equalToSuperview()
            view.bottom.equalTo(datePicker.snp.top).offset(8.0)
        }
        
        dateDownCaretLabel.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(1.13)
            view.top.equalTo(datePicker.snp.bottom).inset(8.0)
        }
        
        yearUpCaretLabel.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(1.55)
            view.top.equalToSuperview()
            view.bottom.equalTo(datePicker.snp.top).offset(8.0)
        }
        
        yearDownCaretLabel.snp.remakeConstraints { (view) in
            view.centerX.equalToSuperview().multipliedBy(1.55)
            view.top.equalTo(datePicker.snp.bottom).inset(8.0)
        }
        
        datePicker.snp.remakeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.height.equalTo(50)
        }
        
        mapSliderView.snp.remakeConstraints { (view) in
            view.leading.trailing.bottom.equalToSuperview()
            //            view.top.equalTo(datePicker.snp.bottom).offset(8.0)
            view.top.equalTo(yearDownCaretLabel.snp.bottom).offset(16.0)
        }
    }
    
    func setUpMapViewLocation() {
        //load mapview for the current date selected on the picker
        let oneDayAgo: Date = calendar.date(byAdding: .day, value: -1, to: Date())!
        self.datePickerDate = returnFormattedDate(date: oneDayAgo)
        fetchSplashForPickerDate(date: self.datePickerDate)
        
        //40.730043, -73.991250
        let center = CLLocationCoordinate2D(latitude: 40.730043, longitude: -73.991250) //40.751085, -73.984946
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.04, longitudeDelta: 0.04))
        self.mapSliderView.mapView.setRegion(region, animated: false)
    }

    func fetchSplashForPickerDate(date: String){
        //Remove all current overlay views prior to populating the map
        self.mapSliderView.mapView.removeOverlays(self.mapSliderView.mapView.overlays)
        
        //Setting database reference to date selected from datePicker
        guard let date = self.datePickerDate else { return }
        self.databaseReference = FIRDatabase.database().reference().child("Public/\(date)")
        
        var overlays: [SplashOverlay] = []
        
        let chronologicalQuery = self.databaseReference.queryOrderedByKey()
        chronologicalQuery.observeSingleEvent(of: FIRDataEventType.value) { (snapshot: FIRDataSnapshot) in
            let enumerator = snapshot.children
            while let child = enumerator.nextObject() as? FIRDataSnapshot {
                
                if let value = child.value as? NSDictionary {
                    if let splashCoor = SplashCoordinate(value) {
                        
                        //draw all splashes parsed from database
                        let splash = SplashOverlay(coor: splashCoor)
                        overlays.append(splash)
                    }
                    self.splashOverlays = overlays
                    self.calculateWinner()
                    
//                    self.setMapPinAndRegion()
                }
            }
        }
    }
    
    func calculateWinner() {
        let linkRef = FIRDatabase.database().reference().child("Public/\(self.datePickerDate!)").child("Score")
        
        linkRef.observeSingleEvent(of: .value, with: { (snapshot) in
            if let value = snapshot.value as? NSDictionary{
                guard let purple = value["purple"] as? Float,
                    let teal = value["teal"] as? Float,
                    let green = value["green"] as? Float,
                    let orange = value["orange"] as? Float else{
                        print("!!!!!Error parsing game score!!!!!")
                        return
                }
                
                self.scoreForDate = [("purple", purple),
                                     ("teal", teal),
                                     ("green", green),
                                     ("orange", orange)]
            }else{
                print("No records found")
            }
        })
    }
    
    func fillInWinnerButton() {
        let winner = self.scoreForDate.sorted { $0.1 > $1.1 }[0].0
        let image = UIImage(named: "logoSplash")
        
        switch winner {
        case "purple":
            self.winnerImage = image?.imageWithColor(color1: SplashColor.teamColor(for: "purple", alpha: 1.0))
        case "teal":
            self.winnerImage = image?.imageWithColor(color1: SplashColor.teamColor(for: "teal", alpha: 1.0))
        case "green":
            self.winnerImage = image?.imageWithColor(color1: SplashColor.teamColor(for: "green", alpha: 1.0))
        case "orange":
            self.winnerImage = image?.imageWithColor(color1: SplashColor.teamColor(for: "orange", alpha: 1.0))
        default:
            return
            
        }
        self.mapSliderView.winnerButton.setImage(self.winnerImage, for: .normal)
        
    }
    
    //MARK: - MKMap Delegate Methods
    func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
        if let myOverlay = overlay as? SplashOverlay{
            let splashOverlay = SplashOverlayView(overlay: myOverlay, teamName: myOverlay.teamName, splashImageTag: myOverlay.splashImageTag)
            return splashOverlay
        }
        return MKOverlayRenderer(overlay: overlay)
    }
    
    //MARK: - Views
    lazy var mapSliderView: MapSliderView = {
        let view = MapSliderView()
        view.mapView.delegate = self
        view.slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: UIControlEvents.touchUpInside)
        view.slider.addTarget(self, action: #selector(sliderMoving(sender:)), for: .valueChanged)
        view.winnerButton.addTarget(self, action: #selector(winnerButtonTapped(_:)), for: .touchUpInside)
        
        return view
    }()

    lazy var datePicker: UIDatePicker = {
        let dp = UIDatePicker()
        dp.setValue(UIColor.white, forKey: "textColor")
        
        //Max date should always be yesterday
        let calendar = Calendar.current
        let oneDayAgo = calendar.date(byAdding: .day, value: -1, to: Date())
        
        //Min date should be 03/10/17 since this is the first day that we have data for
        var dateComponent = DateComponents()
        dateComponent.year = 2017
        dateComponent.month = 03
        dateComponent.day = 10
        let date = Calendar(identifier: Calendar.Identifier.gregorian).date(from: dateComponent)
        
        dp.datePickerMode = .date
        dp.maximumDate = oneDayAgo
        dp.minimumDate = date
        dp.addTarget(self, action: #selector(datePickerChanged(_:)), for: .valueChanged)
        
        return dp
    }()
    
    lazy var monthUpCaretLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "^"
        
        return label
    }()
    
    lazy var monthDownCaretLabel: UILabel = {
       let label = UILabel()
        label.textColor = UIColor.white
        label.text = "^"
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return label
    }()
    
    lazy var dateUpCaretLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "^"
        
        return label
    }()
    
    lazy var dateDownCaretLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "^"
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return label
    }()
    
    lazy var yearUpCaretLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "^"
        
        return label
    }()
    
    lazy var yearDownCaretLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.text = "^"
        label.transform = CGAffineTransform(rotationAngle: CGFloat.pi)
        
        return label
    }()
}
