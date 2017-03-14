//
//  SplashScene.swift
//  SplashDash
//
//  Created by Tong Lin on 3/13/17.
//  Copyright © 2017 SHT. All rights reserved.
//

import SpriteKit

class SplashScene: SKScene {
    
    private var splashNode : SKSpriteNode?
    
    override init(size: CGSize) {
        super.init(size: size)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    override func didMove(to view: SKView) {
        // Create splash when drop ink on map
        let w = (self.size.width + self.size.height) * 0.3
        self.splashNode = SKSpriteNode(imageNamed: "inkSample3")
        if let splash = self.splashNode {
            splash.size = CGSize(width: w, height: w)
            
            splash.run(SKAction.sequence([SKAction.resize(toWidth: 10, height: 10, duration: 0.24),
                                          SKAction.removeFromParent()]))
        }
        
        
    }
    
    func dropSplash(on pos: CGPoint){
        if let splash = self.splashNode?.copy() as! SKSpriteNode? {
            splash.position = pos
            self.addChild(splash)
        }
    }
    
    func stickmanStartRuning(){
        
    }
}
