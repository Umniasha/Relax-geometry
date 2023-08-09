//
//  GameScene.swift
//  Relax geometry
//
//  Created by Oleg Arnaut  on 07.08.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    var contayner : SKSpriteNode!
    var background : SKSpriteNode!
    let containerSize = CGSize(width: UIScreen.main.bounds.size.width / 2.5, height: (UIScreen.main.bounds.size.width / 2.5) / 2.16)
   
    
    
    override func didMove(to view: SKView) {
        scene?.size = UIScreen.main.bounds.size
        
        
        createBackground()
        createPlayerContainer()
        setInterval()
        
        
        
    }
    
   
    
   
    
    func setInterval(){
        
        
           
                let figureRun = SKAction.run {
                let figure = self.createFigures()
                self.addChild(figure)
                   
            }
            
            let figureCreationDelay = SKAction.wait(forDuration: 1.5)
            let figureSequinceAction = SKAction.sequence([figureRun, figureCreationDelay])
            let runAction = SKAction.repeatForever(figureSequinceAction)
            
            run(runAction)
            
           
    }
    
    func createPlayerContainer(){
        
        contayner = SKSpriteNode(imageNamed: "playerContainer")
        
        
        contayner.zPosition = 1
        contayner.size = containerSize
        contayner.position.y = (scene?.frame.minY)! + contayner.size.height / 2
        
        //childContainer()
        addChild(contayner)
        
        
       
    }
    
    func childContainer(){
        var arrayC : [SKSpriteNode] = []
        let figureSize = CGSize(width: createFigures().size.width, height: createFigures().size.height * 1.3)
        let figurePositionX = contayner.position.x - figureSize.width
        for _ in 1...3{
           var position = figurePositionX
        var array = containerFigureArray.shuffled()
        if !array.isEmpty{
            let nameImage = array.remove(at: 0)
            let figure = SKSpriteNode(imageNamed: nameImage)
            figure.size = figureSize
            figure.position.x = position
            figure.zPosition = 2
            figure.name = nameImage
            arrayC.append(figure)
            position += figureSize.width
            
        
    
          }
           
        }
        print(arrayC.count)
       // var textureContainer = SKTexture()
        //
        //contayner.texture = arrayC[1]
    addChild(arrayC[0])//
        addChild(arrayC[1])
      addChild(arrayC[2])
        
    }
    
    func createBackground() {
        
        background = SKSpriteNode(imageNamed: "background")
        background.size = self.scene!.frame.size
        background.zPosition = -1
        
        addChild(background)
        
    }
    
    func createFigures () -> SKSpriteNode {
        let randomFigure = figuresArray.randomElement()
        let figure = SKSpriteNode(imageNamed: randomFigure!)
        let sizeFigure = contayner.size.height / 2.5
        figure.size = CGSize(width: sizeFigure , height: sizeFigure)
        figure.position.x = CGFloat.random(in: (frame.minX + figure.size.width)..<(frame.maxX - figure.size.width))
        figure.run(SKAction.move(to: CGPoint(x: figure.position.x, y: -1000), duration: 15))
        figure.position.y = frame.size.height
        figure.zPosition = 2
        figure.name = randomFigure
        
        
        return figure
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
           
                let touchLocation = touch.location(in: self)
            
            if let maxX = scene?.frame.maxX, let minX = scene?.frame.minX{
                
                if touchLocation.x >= maxX - contayner.size.width / 2 {
                    
                    contayner.position.x = maxX - contayner.size.width / 2
                   
                    } else if touchLocation.x <= minX + contayner.size.width / 2{
                        
                        contayner.position.x = minX + contayner.size.width / 2
                        
                        } else {
                            
                            let timeDuration = CGFloat(sqrt((touchLocation.x - contayner.position.x) * (touchLocation.x - contayner.position.x)) / 500 )
                            let moveContainer = SKAction.move(to: CGPoint(x: touchLocation.x, y: contayner.position.y), duration: timeDuration)
                            contayner.run(moveContainer)
                            
                        }
            }
           
                
            }
            
        }
    override func didEvaluateActions() {
        let arrayOfAllNameFigures  = Square + Ellipses + Triangle
        for name in arrayOfAllNameFigures{
            enumerateChildNodes(withName: name) { figure, stop in
                let heightScreen = UIScreen.main.bounds.height
                if figure.position.y < -heightScreen{
                    figure.removeFromParent()
                }
            }
        }
        
    }
    
    
    
    
    

            
    
}
