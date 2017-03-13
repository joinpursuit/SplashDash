//
//  GE+HelpingFunc.swift
//  SplashDash
//
//  Created by Tong Lin on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import Firebase

extension GameViewController{
    
    func fetchCurrentUserData(){
        if let uid = FIRAuth.auth()?.currentUser?.uid {
            
            let linkRef = FIRDatabase.database().reference().child("Users").child(uid)
            
            linkRef.observeSingleEvent(of: .value, with: { (snapshot) in
                print("snapshot is \(snapshot)")
                if let value = snapshot.value as? NSDictionary{
                    if let user = User(value){
                        self.currentUser = user
                        dump(user)
                    }
                }
            })
        }
    }
    
    func startButtonTapped() {
        print("-----------start button tapped-----------")
        if self.gameStatus{
            gameButton.setTitle("Start", for: .normal)
            endRunUpdate()
        } else{
            animateStartGame()
            toCurrentLocation()
            animateAllButtons()
            gameButton.setTitle("Stop", for: .normal)
        }
        
        gameStatus = !gameStatus
    }
    
    func updateCounter() {
        self.duration += 1
    }
    
    func toCurrentLocation(){
        print("-----------current location button tapped------------")
        if let current = self.locationManager.location{
            print(current)
            let center = CLLocationCoordinate2D(latitude: current.coordinate.latitude, longitude: current.coordinate.longitude)
            let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
            
            self.mapView.setRegion(region, animated: true)
        }
    }
    
    
    func animateAllButtons(){
        
        if self.isButtonsOffScreen{
            
            UIView.animate(withDuration: 0.30, delay: 0, usingSpringWithDamping: 0.70, initialSpringVelocity: 0.25, options: [], animations: {
                //Leaderboard views
                self.firstPlaceView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.secondPlaceView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.thirdPlaceView.transform = CGAffineTransform(translationX: 0, y: 0)
                self.fourthPlaceView.transform = CGAffineTransform(translationX: 0, y: 0)
                
                self.gameButton.transform = CGAffineTransform.identity
                self.findMeButton.transform = CGAffineTransform(translationX: 0, y: 0)
                //                self.endGameButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }, completion: nil)
        }
        else {
            
            UIView.animate(withDuration: 0.20, delay: 0, usingSpringWithDamping: 0, initialSpringVelocity: 0, options: [], animations: {
                //Leaderboard views
                self.firstPlaceView.transform = CGAffineTransform(translationX: 215, y: 0)
                self.secondPlaceView.transform = CGAffineTransform(translationX: 200, y: 0)
                self.thirdPlaceView.transform = CGAffineTransform(translationX: 200, y: 0)
                self.fourthPlaceView.transform = CGAffineTransform(translationX: 175, y: 0)
                
                self.gameButton.transform = CGAffineTransform(translationX: 175, y: 0)
                self.findMeButton.transform = CGAffineTransform(translationX: 175, y: 0)
                //                self.endGameButton.transform = CGAffineTransform(translationX: 175, y: 0)
            }, completion: nil)
        }
        
        self.isButtonsOffScreen = !self.isButtonsOffScreen
    }
    
    func animateStartGame(){
        self.displayView.isHidden = false
        let countDownLabels = ["3", "2", "1", "GO!"]
        var colorArr = SplashColor.teamColorArray()
        
        for char in countDownLabels.reversed(){
            let label = UILabel()
            label.text = char
            label.textColor = colorArr.removeLast()
            label.textAlignment = .center
            label.font = UIFont.boldSystemFont(ofSize: 120)
            
            
            allLabel.append(label)
            view.addSubview(label)
            label.snp.makeConstraints { (view) in
                view.center.equalToSuperview()
                view.size.equalTo(CGSize(width: 1, height: 1))
            }
        }
        
        self.view.layoutIfNeeded()
        
        self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(startGameTimer), userInfo: nil, repeats: true)
    }
    
    func startGameTimer(){
        guard let label = allLabel.popLast() else {
            displayView.isHidden = true
            self.updateCounter()
            return
        }
        
        let animator = UIViewPropertyAnimator(duration: 0.2, curve: .easeIn, animations: nil)
        
        animator.addAnimations {
            label.snp.remakeConstraints({ (view) in
                view.top.bottom.leading.trailing.equalToSuperview()
            })
            self.view.layoutIfNeeded()
        }
        
        animator.addCompletion { (_) in
            DispatchQueue.main.asyncAfter(deadline: .now()+0.7, execute: {
                label.removeFromSuperview()
                
            })
        }
        
        animator.startAnimation()
    }

    func takeScreenshot() {
        
        guard let contentScrollView = self.invisibleMapView.subviews.first?.subviews.first else { return }
        
        UIGraphicsBeginImageContextWithOptions(contentScrollView.bounds.size, false, 0.0)
        
        contentScrollView.drawHierarchy(in: contentScrollView.bounds, afterScreenUpdates: true)
        
        guard let screenShot = UIGraphicsGetImageFromCurrentImageContext() else { return }
        UIGraphicsEndImageContext()
        
//        UIImageWriteToSavedPhotosAlbum(screenShot, nil, nil, nil)
        self.currentScore = colorArray(image: screenShot)
        print(currentScore)
        
        //updating leaderboard count and handle colors
        updateLeaderboard()
        
    }
    
    func colorArray(image: UIImage) -> [(color: String, score: Double)] {
        
        var purpleCoverage = 0.0
        var tealCoverage = 0.0
        var greenCoverage = 0.0
        var orangeCoverage = 0.0
        
        var total: Double = 0.0
        
        guard let img = image.cgImage else { return [] }
        let width = img.width
        let height = img.height
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var rawData = [UInt8](repeating: 0, count: width * height * 4)
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bytesPerComponent = 8
        
        let bitmapInfo = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        let context = CGContext(data: &rawData, width: width, height: height, bitsPerComponent: bytesPerComponent, bytesPerRow: bytesPerRow, space: colorSpace, bitmapInfo: bitmapInfo)
        context?.draw(img, in: CGRect(x: 0, y: 0, width: CGFloat(width), height: CGFloat(height)))
        for x in 0..<height {
            for y in 0..<width {
                let byteIndex = (bytesPerRow * x) + y * bytesPerPixel
                let red   = rawData[byteIndex]
                let green = rawData[byteIndex + 1]
                let blue  = rawData[byteIndex + 2]
                // (103, 58, 183) for purple
                // (0, 188, 212)  for teal
                // (76, 175, 80)  for green
                // (255, 87, 34)  for orange
                switch (red, green, blue) {
                case (93...113, 48...68, 173...193):
                    purpleCoverage += 1.0
                    total += 1.0
                default: ()
                }
                
                switch (red, green, blue) {
                case (0...10, 178...198, 202...222):
                    tealCoverage += 1.0
                    total += 1.0
                default: ()
                }
                
                switch (red, green, blue) {
                case (66...86, 165...185, 70...90):
                    greenCoverage += 1.0
                    total += 1.0
                default: ()
                }
                
                switch (red, green, blue) {
                case (245...255, 77...97, 24...44):
                    orangeCoverage += 1.0
                    total += 1.0
                default: ()
                }
            }
        }
        //return winer
        print("\(height),  \(width)")
        return [("purple", purpleCoverage/total),
                ("teal", tealCoverage/total),
                ("green", greenCoverage/total),
                ("orange", orangeCoverage/total)]
    }
    
    func updateLabel() {
        
        var components = DateComponents()
        components.day = 1
        components.second = -1
        guard let end = Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: Date())) else { return }
        
        let diff = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: Date(), to: end)
        
        if let diffHour = diff.hour {
        bottomView.hoursLeftLabel.text = "Hours left: \(diffHour)"
        }
//        bottomView.currentRunLabel.text = "Hours left: \(diff.hour!):\(diff.minute!):\(diff.second!)"
        
    }
    
    func updateLeaderboard() {
        let sortedScores = self.currentScore.sorted { $0.score > $1.score }
        
        self.firstPlaceView.teamNameLabel.text = "\(sortedScores[0].color)"
        self.firstPlaceView.backgroundColor = SplashColor.teamColor(for: "\(sortedScores[0].color)")
        
        self.secondPlaceView.teamNameLabel.text = "\(sortedScores[1].color)"
        self.secondPlaceView.backgroundColor = SplashColor.teamColor(for: "\(sortedScores[1].color)")
        
        self.thirdPlaceView.teamNameLabel.text = "\(sortedScores[2].color)"
        self.thirdPlaceView.backgroundColor = SplashColor.teamColor(for: "\(sortedScores[2].color)")
        
        self.fourthPlaceView.teamNameLabel.text = "\(sortedScores[3].color)"
        self.fourthPlaceView.backgroundColor = SplashColor.teamColor(for: "\(sortedScores[3].color)")
        
        UIView.animate(withDuration: 0.5) {
            self.firstPlaceView.alpha = 1
            self.secondPlaceView.alpha = 1
            self.thirdPlaceView.alpha = 1
            self.fourthPlaceView.alpha = 1
        }
        
    }

}
