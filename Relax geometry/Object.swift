//
//  Object.swift
//  Relax geometry
//
//  Created by Oleg Arnaut  on 13.08.2023.
//

import SpriteKit
import Foundation

class Figure{
    let texture : String
    let name : String
    let sizeWidth: CGFloat
    let sizeHeight:CGFloat
    let zPozition : CGFloat
    let positionX: CGFloat
    let positionY: CGFloat
    let runTo :CGPoint!
    let duration : CGFloat!
    let physicCircleRadius : Double
    let isDynamic : Bool
    let categoryBitMask : UInt32
    let contactBitMask : UInt32
    let usesPreciseCollision:Bool
    
    init (texture : String,name : String, sizeWidth: CGFloat,sizeHeight:CGFloat, zPozition : CGFloat,positionX: CGFloat,positionY: CGFloat,runTo :CGPoint,duration : CGFloat,physicCircleRadius : CGFloat, isDynamic : Bool,categoryBitMask : UInt32,contactBitMask : UInt32,usesPreciseCollision:Bool){
        self.texture = texture
        self.name = name
        self.sizeWidth = sizeWidth
        self.sizeHeight = sizeHeight
        self.zPozition = zPozition
        self.positionX = positionX
        self.positionY = positionY
        self.runTo = runTo
        self.duration = duration
        self.physicCircleRadius = physicCircleRadius
        self.isDynamic = isDynamic
        self.categoryBitMask = categoryBitMask
        self.contactBitMask = contactBitMask
        self.usesPreciseCollision = usesPreciseCollision
    }
    
    func addObject(nameObject:SKSpriteNode, scene: SKScene){
        nameObject.texture = SKTexture(imageNamed: texture)
        nameObject.size.width = sizeWidth
        nameObject.size.height = sizeHeight
        nameObject.zPosition = zPozition
        nameObject.position.x = positionX
        nameObject.position.y = positionY
        if let runTo = runTo {
        nameObject.run(SKAction.move(to: runTo, duration: duration!))
        }
        nameObject.physicsBody = SKPhysicsBody(circleOfRadius: physicCircleRadius)
        nameObject.physicsBody?.isDynamic = isDynamic
        nameObject.physicsBody?.categoryBitMask = categoryBitMask
        nameObject.physicsBody?.contactTestBitMask = contactBitMask
        nameObject.physicsBody?.usesPreciseCollisionDetection = usesPreciseCollision
        scene.addChild(nameObject)
    }
    
    
}


//
//bonusStar = SKSpriteNode(imageNamed: "star")
//bonusStar.size = CGSize(width: container.size.height / 2, height: container.size.height / 2)
//bonusStar.zPosition = 5
//bonusStar.name = "star"
//bonusStar.position.x = CGFloat.random(in: (frame.minX + bonusStar.size.width)..<(frame.maxX - bonusStar.size.width))
//bonusStar.run(SKAction.move(to: CGPoint(x: bonusStar.position.x, y: -1000), duration: 20 ))
//bonusStar.position.y = frame.maxY + bonusStar.size.height
//bonusStar.physicsBody = SKPhysicsBody(circleOfRadius: 0.1)
//bonusStar.physicsBody?.isDynamic = true
//
//bonusStar.physicsBody?.categoryBitMask = PhysicsCategories.figure
//bonusStar.physicsBody?.contactTestBitMask = PhysicsCategories.cell
//bonusStar.physicsBody?.collisionBitMask = 0
//bonusStar.physicsBody?.usesPreciseCollisionDetection = true
