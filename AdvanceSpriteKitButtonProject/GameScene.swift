//
//  GameScene.swift
//  AdvanceSpriteKitButtonProject
//
//  Created by Skyler Lauren on 9/2/17.
//  Copyright © 2017 SkyVan Labs. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SVLSpriteNodeButtonDelegate {
    
    var leftArrowButton: SVLSpriteNodeButton!
    var rightArrowButton: SVLSpriteNodeButton!
    var shootButton: SVLSpriteNodeButton!
    
    var ship: SKSpriteNode!

    var lastUpdateTime: TimeInterval = 0
    var shipSpeed: CGFloat = 10.0
    
    //MARK: - Scene Stuff
    override func didMove(to view: SKView) {
        
        leftArrowButton = childNode(withName: "leftArrowButton") as! SVLSpriteNodeButton
        
        rightArrowButton = childNode(withName: "rightArrowButton") as! SVLSpriteNodeButton
        
        shootButton = childNode(withName: "shootButton") as! SVLSpriteNodeButton
        shootButton.delegate = self
        
        ship = childNode(withName: "ship") as! SKSpriteNode
        shipSpeed = size.width/2.0

    }
    
    override func update(_ currentTime: TimeInterval) {
        
        let dt = currentTime - lastUpdateTime
        
        if leftArrowButton.state == .down{
            ship.position.x -= shipSpeed * CGFloat(dt)
        }
        
        if ship.position.x < -size.width/2+ship.size.width/2{
            ship.position.x = -size.width/2+ship.size.width/2
        }
        
        if rightArrowButton.state == .down{
            ship.position.x += shipSpeed * CGFloat(dt)
        }
        
        if ship.position.x > size.width/2-ship.size.width/2{
            ship.position.x = size.width/2-ship.size.width/2
        }
        
        lastUpdateTime = currentTime
    }
    
    func shoot(){
        let bullet = SKSpriteNode(color: SKColor.red, size: CGSize(width: 10, height: 20))
        bullet.position = ship.position
        bullet.position.y += ship.size.height/2 + bullet.size.height/2
        addChild(bullet)
        
        let moveUpAction = SKAction.moveBy(x: 0, y: size.height, duration: 1.0)
        let destroy = SKAction.removeFromParent()
        let sequence = SKAction.sequence([moveUpAction, destroy])
        
        bullet.run(sequence)
    }
    
    //MARK: - SVLSpriteNodeButtonDelegate
    func spriteButtonDown(_ button: SVLSpriteNodeButton){
        print("spriteButtonDown")
    }
    
    func spriteButtonUp(_ button: SVLSpriteNodeButton){
        print("spriteButtonUp")
    }
    
    func spriteButtonMoved(_ button: SVLSpriteNodeButton){
        print("spriteButtonMoved")
    }
    
    func spriteButtonTapped(_ button: SVLSpriteNodeButton){
        if button == shootButton {
            shoot()
        }
    }
}
