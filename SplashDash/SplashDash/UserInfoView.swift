//
//  UserInfoView.swift
//  SplashDash
//
//  Created by Sabrina Ip on 3/1/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import AVFoundation
import AVKit

/*
 //For testing purposes - use this code to instantiate
        let uiv = UserInfoView()
        view.addSubview(uiv)
        
        uiv.snp.makeConstraints { (view) in
            view.leading.trailing.top.bottom.equalToSuperview()
        }
        uiv.backgroundColor = SplashColor.primaryColor()
*/
 
class UserInfoView: UIView, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    private var profileImage: UIImage = UIImage()

    override func draw(_ rect: CGRect) {
        super.draw(rect)
//        self.backgroundColor = SplashColor.primaryColor() // background color is not changing
        setupViewHierarchy()
        configureConstraints()
    }

    func setupViewHierarchy() {
        self.addSubview(profileImageView)
        self.addSubview(historyLabel)
        self.addSubview(userHistoryTableView)
        self.addSubview(logoutButton)
    }
    
    func configureConstraints() {
        profileImageView.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.top.equalToSuperview().inset(20.0)
            view.height.equalTo(150.0)
            view.width.equalTo(profileImageView.snp.height)
        }
        
        historyLabel.snp.makeConstraints { (view) in
            view.top.equalTo(profileImageView.snp.bottom).offset(16.0)
            view.leading.equalToSuperview().offset(8.0)
        }
        
        logoutButton.snp.makeConstraints { (view) in
            view.centerX.equalToSuperview()
            view.bottom.equalToSuperview().inset(20.0)
            view.width.equalTo(200.0)
        }
        
        userHistoryTableView.snp.makeConstraints { (view) in
            view.leading.trailing.equalToSuperview()
            view.top.equalTo(historyLabel.snp.bottom).offset(8.0)
            view.bottom.equalTo(logoutButton.snp.top).offset(-16.0)
        }
    }
    
    // MARK: - Actions
    
    func logoutButtonTapped(){
        print("logout button tapped")
    }
    
    func imageTapped(){
        print("image tapped")
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        
        //TO DO: FIGURE OUT HOW TO PRESENT FROM VIEW
//        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    //MARK: - UIImagePickerControllerDelegate
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {

        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.profileImageView.image = image
        }

//        dismiss(animated: true)
    }

    
    // MARK: - TableView Methods
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.cellIdentifier, for: indexPath) as! HistoryTableViewCell
        
        cell.runLabel.text = "Date: 4/3/13\nTime: 3:33PM\nDistance: 2.5 miles\nDuration: 30 mins\nAverage Speed: \(2.5/0.5) mph"
                
        return cell
    }
    
    // MARK: - Views
    
    private lazy var profileImageView: UIImageView = {
        let imageView = UIImageView()
//        imageView.image = self.profileImage
        imageView.backgroundColor = .lightGray
        imageView.contentMode = .scaleAspectFill
        let tapImageGesture = UITapGestureRecognizer(target: self, action: #selector(imageTapped))
        imageView.addGestureRecognizer(tapImageGesture)
        imageView.isUserInteractionEnabled = true
        imageView.frame.size = CGSize(width: 200.0, height: 200.0)
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = imageView.frame.height * 0.05
        return imageView
    }()
    
    private lazy var historyLabel: UILabel = {
        let label = UILabel()
        label.text = "HISTORY"
        label.textColor = SplashColor.lightPrimaryColor()
        return label
    }()
    
    private lazy var userHistoryTableView: UITableView = {
        let tView = UITableView()
        tView.delegate = self
        tView.dataSource = self
        tView.register(HistoryTableViewCell.self, forCellReuseIdentifier: HistoryTableViewCell.cellIdentifier)
        tView.estimatedRowHeight = 250
        tView.rowHeight = UITableViewAutomaticDimension
        return tView
    }()
    
    private lazy var logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("LOG OUT", for: .normal)
        button.backgroundColor = SplashColor.darkPrimaryColor()
        button.addTarget(self, action: #selector(logoutButtonTapped), for: .touchUpInside)
        return button
    }()
}
