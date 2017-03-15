//
//  SplashScene.swift
//  SplashDash
//
//  Created by Tong Lin on 3/13/17.
//  Copyright © 2017 SHT. All rights reserved.
//
import UIKit
import SpriteKit

class SplashScene: SKScene {
    
    private var splashNode : SKSpriteNode?
    private var stickmanNode : SKSpriteNode?
    private var runningMotion: SKAction?
    
    private var readySignNodes: [SKLabelNode] = []
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func didMove(to view: SKView) {
        // Create splash when drop ink on map
        let w = (self.size.width + self.size.height) * 0.2
        self.splashNode = SKSpriteNode(imageNamed: "inkSample3")
        if let splash = self.splashNode {
            splash.size = CGSize(width: w, height: w)
            splash.run(SKAction.sequence([SKAction.fadeOut(withDuration: 0.8),
                                          SKAction.removeFromParent()]))
        }
        
        //stickman setup
        self.stickmanNode = SKSpriteNode(imageNamed: "Run_1")
        var runningMotions: [SKTexture] = []
        
        for index in 1...24{
            let texture = SKTexture(imageNamed: "Run_\(index)")
            runningMotions.append(texture)
        }
        
        let runningAnimation = SKAction.animate(with: runningMotions, timePerFrame: 0.05)
        self.runningMotion = SKAction.repeatForever(runningAnimation)
        
        
        //prepare all label sign node
        let countDownLabels = ["3", "2", "1", "GO!"]
        var colorArr = SplashColor.teamColorArray()
        
        for char in countDownLabels{
            let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
            label.text = char
            label.fontColor = colorArr.removeLast()
            label.fontSize = 120
            label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
            
            readySignNodes.append(label)
        }
    }
    
    func beforeStartGame(completion: @escaping (()->Void)){
        for label in readySignNodes{
            label.alpha = 1.0
        }
        
        self.addChild(readySignNodes[0])
        readySignNodes[0].run(SKAction.fadeOut(withDuration: 1)) {
            self.addChild(self.readySignNodes[1])
            self.readySignNodes[1].run(SKAction.fadeOut(withDuration: 1)) {
                self.addChild(self.readySignNodes[2])
                self.readySignNodes[2].run(SKAction.fadeOut(withDuration: 1)) {
                    self.addChild(self.readySignNodes[3])
                    self.readySignNodes[3].run(SKAction.fadeOut(withDuration: 1)) {
                        //end count down
                        completion()
                        self.readySignNodes[3].removeFromParent()
                        self.readySignNodes[2].removeFromParent()
                        self.readySignNodes[1].removeFromParent()
                        self.readySignNodes[0].removeFromParent()
                    }
                }
            }
        }
        
    }
    
    func dropSplash(on pos: CGPoint, with: UIImage){
        if let splash = self.splashNode?.copy() as! SKSpriteNode? {
            splash.texture = SKTexture(image: with)
            splash.position = pos
            self.addChild(splash)
        }
    }
    
    func stickmanInit(){
        let origin = CGPoint(x: self.frame.minX-50, y: self.frame.minY+50)
        self.stickmanNode!.position = origin
        self.stickmanNode!.setScale(0.3)
        
        self.addChild(self.stickmanNode!)
    }
    
    func stickmanStartRunning(to pos: CGPoint){
        self.stickmanNode!.run(self.runningMotion!)
        self.stickmanNode!.run(SKAction.move(to: pos, duration: 4))
    }
    
    func stickmanRunningOffScreen(to pos: CGPoint){
        self.stickmanNode!.run(SKAction.move(to: pos, duration: 1)) { 
            self.stickmanNode?.removeFromParent()
            self.stickmanInit()
        }
    }
    
    func printErrorMessage(str: String, fontColor: UIColor){
        let label = SKLabelNode(fontNamed: "AvenirNext-Bold")
        label.text = str
        label.fontColor = fontColor
        label.fontSize = 30
        label.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(label)
        label.run(SKAction.fadeOut(withDuration: 3)) {
            label.removeFromParent()
        }
    }
}
