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
        if currentUser == nil{
            let uid = FIRAuth.auth()?.currentUser?.uid
            
            let linkRef = FIRDatabase.database().reference().child("Users").child(uid!)
            
            linkRef.observeSingleEvent(of: .value, with: { (snapshot) in
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
        }else{
            toCurrentLocation()
            gameButton.setTitle("Stop", for: .normal)
            animateAllButtons()
        }
        
        gameStatus = !gameStatus
    }
    
    func readyToScreenshot(){
        endGame = true
        let center = CLLocationCoordinate2D(latitude: 40.750101, longitude: -73.988439)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        
        self.mapView.setRegion(region, animated: true)
        
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
        UIView.animate(withDuration: 0.8, animations: {
            if self.isButtonsOffScreen{
                self.gameButton.transform = CGAffineTransform(translationX: 0, y: 0)
                self.findMeButton.transform = CGAffineTransform(translationX: 0, y: 0)
            }else{
                self.gameButton.transform = CGAffineTransform(translationX: 150, y: 0)
                self.findMeButton.transform = CGAffineTransform(translationX: 150, y: 0)
            }
            self.isButtonsOffScreen = !self.isButtonsOffScreen
        }, completion: nil)
    }
    
    

    
    
    func takeScreenshot() {
        
        guard let contentScrollView = self.mapView.subviews.first?.subviews.first else { return }
        
        UIGraphicsBeginImageContextWithOptions(contentScrollView.bounds.size, false, UIScreen.main.scale)
        
        contentScrollView.drawHierarchy(in: contentScrollView.bounds, afterScreenUpdates: true)
        
        let screenShot = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
//        UIImageWriteToSavedPhotosAlbum(screenShot!, nil, nil, 
        colorArray(image: screenShot!)
    }
    
    func colorArray(image: UIImage) {
        var result = 0
        
        let img = image.cgImage!
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
        for x in 0..<width {
            for y in 0..<height {
//                let byteIndex = (bytesPerRow * x) + y * bytesPerPixel
                
//                let red   = CGFloat(rawData[byteIndex]    ) / 255.0
//                let green = CGFloat(rawData[byteIndex + 1]) / 255.0
//                let blue  = CGFloat(rawData[byteIndex + 2]) /
//                let alpha = CGFloat(rawData[byteIndex + 3]) / 255.0
                
//                print("\(red), \(green), \(blue)")
                result += 1
                //                let color = UIColor(red: red, green: green, blue: blue, alpha: alpha)
                //                result[color] = (result[color] ?? 0) + 1
            }
        }
        print(result)
        
    }
    
    func updateLabel() {
        
        var components = DateComponents()
        components.day = 1
        components.second = -1
        let end = Calendar.current.date(byAdding: components, to: Calendar.current.startOfDay(for: Date()))
        
        let diff = Calendar.current.dateComponents([Calendar.Component.hour, Calendar.Component.minute, Calendar.Component.second], from: Date(), to: end!)
        
        countDownLabel.text = "Hours left: \(diff.hour!)"
        
    }
}
