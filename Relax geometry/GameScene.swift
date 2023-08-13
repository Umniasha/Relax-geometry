//
//  GameScene.swift
//  Relax geometry
//
//  Created by Oleg Arnaut  on 07.08.2023.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    var SCORE = 0
    var CountOfHearts : UInt = 3
    
    var gameViewController : GameViewController!
    var hidenRechtangle : SKSpriteNode!
    var container : SKSpriteNode!
    var background : SKSpriteNode!
    var figure : SKSpriteNode!
    let containerSize = CGSize(width: UIScreen.main.bounds.size.width / 2,
                               height: (UIScreen.main.bounds.size.width / 2) / 2.16)
    var cell = SKSpriteNode()
    
    var starCreateTimer:Timer = Timer()
    var figureCreateTimer:Timer = Timer()
    var starCellCreateTimer:Timer = Timer()
    var bombCreateTimer:Timer = Timer()
    var difficultyTimer:Timer = Timer()
    
    var enabledFigures:[String] = []
    var isHiddenBar = false
    var scoreBar = SKSpriteNode()
    var scoreLable = SKLabelNode()
    var figureSpeedInterval:Double = 15
    var figureCreationInterval:Double = 3
    var bombCreationInterval:Double = 10
    var starCreationInterval: Double = 25
    var bomb = SKSpriteNode()
    var heart = SKSpriteNode()
    var array : [SKSpriteNode] = []
    var bonusStar = SKSpriteNode()
    var cellArray = [SKSpriteNode]()
    var starCell = SKSpriteNode()
    var contactBody = Bool()
    var isBonus = false
   
   
  

    
    override  func didMove(to view: SKView) {
      
        
        playGame()
      
        
    }
    
    func playGame (){
        self.isPaused = false
        scene?.size = UIScreen.main.bounds.size
       
        physicsWorld.contactDelegate = self
        physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        
        CountOfHearts = 3
        SCORE = 0
        contactBody = false
        hideNotch()
        createScoreBar()
        heartsCount(count: Int(CountOfHearts))
        createBackground()
        createPlayerContainer()
        addingObjects()
        
        if isDifficulty{
            setDifficulty()
        }
        
    }
    
    func setDifficulty(){
        let randomTime = Double.random(in: 15...30)
       
        difficultyTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(difficultyUpdate), userInfo: nil, repeats: true)
    }
    
    @objc func difficultyUpdate(){
        if isBonus{
            starCell.removeFromParent()
        }
        container.removeAllChildren()
        for cell in createCellContainer(){
            container.addChild(cell)
        }
    }
    
    func addingObjects(){
        
        figureCreateTimer = Timer.scheduledTimer(timeInterval: figureCreationInterval, target: self, selector:
                                                    #selector(createFigures), userInfo: nil, repeats: true)
        
        bombCreateTimer = Timer.scheduledTimer(timeInterval: bombCreationInterval, target: self, selector:
                                                #selector(createBomb), userInfo: nil, repeats: true)
        
        starCreateTimer = Timer.scheduledTimer(timeInterval: starCreationInterval, target: self, selector:
                                                #selector(createStar), userInfo: nil, repeats: true)
    }
    
    func gameOver(){
        
        self.isPaused = true
        if SCORE > recordScore && fastestLoss == 0{
            recordScore = SCORE
            fastestLoss = SCORE
        } else if SCORE < fastestLoss{
            fastestLoss = SCORE
        }else if SCORE > recordScore {
            recordScore = SCORE
        }
        print(recordScore, fastestLoss)
        saveData()
        
        removeAllChildren()
        starCreateTimer.invalidate()
    figureCreateTimer.invalidate()
    starCellCreateTimer.invalidate()
    bombCreateTimer.invalidate()
        
            gameViewController.buttonStackView.isHidden = false
        gameViewController.bgImage.isHidden = false
        gameViewController.heartImage.isHidden = false
        gameViewController.homeButton.isHidden = true
        
    }
    
    
    
    

    
    func createStarCell(){
        starCell = SKSpriteNode(imageNamed: "starCell")
        starCell.position.y = 1
        starCell.size.height = cell.size.height
        starCell.size.width = cell.size.width * 3 + cell.size.width / 10 * 2
        starCell.zPosition = 3
        starCell.name = "starCell"
        starCell.physicsBody = SKPhysicsBody(texture: starCell.texture!, size: starCell.size)
        starCell.physicsBody?.isDynamic = true
        
        starCell.physicsBody?.categoryBitMask = PhysicsCategories.cell
        starCell.physicsBody?.contactTestBitMask = PhysicsCategories.figure
        starCell.physicsBody?.collisionBitMask = 0
        //starCell.physicsBody?.usesPreciseCollisionDetection = true

        container.addChild(starCell)
    }
    
    
   @objc func createStar (){
        bonusStar = SKSpriteNode(imageNamed: "star")
        bonusStar.size = CGSize(width: container.size.height / 2, height: container.size.height / 2)
        bonusStar.zPosition = 5
        bonusStar.name = "star"
        bonusStar.position.x = CGFloat.random(in: (frame.minX + bonusStar.size.width)..<(frame.maxX - bonusStar.size.width))
        bonusStar.run(SKAction.move(to: CGPoint(x: bonusStar.position.x, y: -1000), duration: 20 ))
        bonusStar.position.y = frame.maxY + bonusStar.size.height
       bonusStar.physicsBody = SKPhysicsBody(circleOfRadius: 0.1)
        bonusStar.physicsBody?.isDynamic = true
       
        bonusStar.physicsBody?.categoryBitMask = PhysicsCategories.figure
        bonusStar.physicsBody?.contactTestBitMask = PhysicsCategories.cell
        bonusStar.physicsBody?.collisionBitMask = 0
        bonusStar.physicsBody?.usesPreciseCollisionDetection = true
        addChild(bonusStar)
    }
    
    @objc func createBomb (){
        bomb = SKSpriteNode(imageNamed: "bomb")
        bomb.size.width =  container.size.height / 2.5
        bomb.size.height = bomb.size.width * 1.5
        bomb.zPosition = 5
        //bomb.physicsBody = SKPhysicsBody(texture: bomb.texture!, size: bomb.size)
        bomb.physicsBody = SKPhysicsBody(circleOfRadius: 3)
        bomb.physicsBody?.isDynamic = true
        bomb.run(SKAction.move(to: CGPoint(x: bomb.position.x, y: -1000), duration: 10 ))
        bomb.physicsBody?.categoryBitMask = PhysicsCategories.figure
        bomb.physicsBody?.contactTestBitMask = PhysicsCategories.cell
        bomb.physicsBody?.collisionBitMask = 0
        bomb.physicsBody?.usesPreciseCollisionDetection = true
        bomb.position.x = CGFloat.random(in: (frame.minX + bomb.size.width)..<(frame.maxX - bomb.size.width))
        bomb.position.y = frame.maxY + bomb.size.height
        bomb.name = "bomb"
        addChild(bomb)
    }
    
    override func update(_ currentTime: TimeInterval) {
        contactBody = false
    }
    
    
    
    
    func didEnd(_ contact: SKPhysicsContact) {
         
    }
    

    
    func didBegin(_ contact: SKPhysicsContact) {
       
        if let bodyA = contact.bodyA.node?.name{
            for figureName in figureArray{
                if      dict[bodyA] == contact.bodyB.node?.name  {
                   
                    if contactBody == false {
                    contact.bodyB.categoryBitMask = 0
                    contact.bodyB.node?.removeFromParent()
                    addScore()
                    scoreLable.text = String(SCORE)
                        switch dict[bodyA] {
                        case  "EllipseGreen", "EllipseRed", "EllipseWhite" : caughtCircles += 1
                        case "SquareGreen",  "SquareRed",  "SquareWhite" : caughtSquares += 1
                        case "TriangleGreen",  "TriangleRed", "TriangleWhite": caughtTriangles += 1
                        default : return
                        }
                        print(caughtCircles,caughtSquares,caughtTriangles)
                    }
                    contactBody = true
                } else if contact.bodyB.node?.name == "bomb" && contact.bodyA.node?.name == "container"{
                    
                    if contactBody == false {
                    contact.bodyB.categoryBitMask = 100
                    contact.bodyB.node?.removeFromParent()
                        dodgedTheBomb += 1

                    if CountOfHearts != 0{
                        removeHeart()

                        for i in array{
                            i.removeFromParent()
                        }
                    }

                    heartsCount(count: Int(CountOfHearts))
                    if CountOfHearts == 0 {
                        gameOver()
                    }
                    }
                    contactBody = true

                }else if contact.bodyB.node?.name == "star" && contact.bodyA.node?.name == "container"{
                    if contactBody == true {
                        contactBody = false
                    }
                    if contactBody == false {
                    contact.bodyB.categoryBitMask = 0
                    contact.bodyB.contactTestBitMask = 0
                    contact.bodyB.node?.removeFromParent()
                    caughtBonus += 1
                    starCell.removeFromParent()
                    createStarCell()
                        isBonus = true
                    for cell in cellArray{
                        cell.isHidden = true
                        cell.physicsBody?.contactTestBitMask = 0
                        cell.physicsBody?.categoryBitMask = 0
                    }

                    starCellCreateTimer = Timer.scheduledTimer(timeInterval: 15, target: self, selector: #selector(starCellTimer), userInfo: nil, repeats: false)

                    }
                    contactBody = true
                }else if  contact.bodyA.node?.name == "starCell" &&
                    contact.bodyB.node?.name == figureName  &&  contact.bodyA.node?.name != dict[bodyA]{
                    if contactBody == true {
                        contactBody = false
                    }
                    if contactBody == false {
                        switch contact.bodyB.node?.name {
                        case  "EllipseGreen", "EllipseRed", "EllipseWhite" : caughtCircles += 1
                        case "SquareGreen",  "SquareRed",  "SquareWhite" : caughtSquares += 1
                        case "TriangleGreen",  "TriangleRed", "TriangleWhite": caughtTriangles += 1
                        default : return
                        }
                        
                    contact.bodyB.categoryBitMask = 0
                    contact.bodyB.contactTestBitMask = 0
                    contact.bodyB.node?.removeFromParent()
        
                    addScore()
                    scoreLable.text = String(SCORE)
                    }
                    contactBody = true
                } else if contact.bodyA.node?.name != contact.bodyB.node?.name && contact.bodyB.node?.name == figureName && contact.bodyA.node?.name != "container" && contact.bodyA.node?.name != "starCell"{
                    if contactBody == true {
                        contactBody = false
                    }
                    if contactBody == false {
                      
                        
                    contact.bodyB.categoryBitMask = 0
                    contact.bodyB.node?.removeFromParent()
                    errorsColour += 1
                    
                    if CountOfHearts != 0{
                        removeHeart()

                        for i in array{
                            i.removeFromParent()
                        }
                    }

                    heartsCount(count: Int(CountOfHearts))
                    if CountOfHearts == 0 {
                        gameOver()
                    }
                    
                }
                 }
                    contactBody = true
            }
        }
    }
 
    
    
    
    @objc func starCellTimer(){
        for cell in cellArray{
            cell.isHidden = false
            cell.physicsBody?.categoryBitMask = PhysicsCategories.cell
            cell.physicsBody?.contactTestBitMask = PhysicsCategories.figure
        }
        
        isBonus = false
        starCell.removeFromParent()
        starCellCreateTimer.invalidate()
        
    }
    
   
    
   
    
    func createPlayerContainer(){
        
        container = SKSpriteNode(imageNamed: "playerContainer")
        
        
        container.zPosition = 1
        container.size = containerSize
        container.position.y = (scene?.frame.minY)! + container.size.height / 2
        container.physicsBody = SKPhysicsBody(texture: container.texture!, size: container.size)
        container.physicsBody?.isDynamic = false
        container.name = "container"
        container.physicsBody?.categoryBitMask = PhysicsCategories.cell
        container.physicsBody?.contactTestBitMask = PhysicsCategories.figure
        container.physicsBody?.collisionBitMask = 0
        container.physicsBody?.usesPreciseCollisionDetection = true
        
        addChild(container)
       
        for cell in createCellContainer(){
            container.addChild(cell)
        }
        
        
       
    }
    
    func createCellContainer() -> [SKSpriteNode]{
        var array = containerFigureArray.shuffled()
        var nameImage = ""
        
        let position = CGPoint(x: 0 , y: 1)
       
        for _ in 1...3 {
            
        if !array.isEmpty{
             nameImage = array.remove(at: 0)
          }
            enabledFigures.append(dict[nameImage] ?? "")
            cell = SKSpriteNode(imageNamed: nameImage)
            cell.zPosition = 3
            cell.size = CGSize(width: containerSize.width / 4.4 , height: containerSize.height / 1.5)
            cell.position = position
            cell.name = nameImage
            cell.physicsBody = SKPhysicsBody(texture: cell.texture!, size: cell.size)
            cell.physicsBody?.isDynamic = true
            
            cell.physicsBody?.categoryBitMask = PhysicsCategories.cell
            cell.physicsBody?.contactTestBitMask = PhysicsCategories.figure
            cell.physicsBody?.collisionBitMask = 0
            cell.physicsBody?.usesPreciseCollisionDetection = true
            
            
            cellArray.append(cell)
            
          
        }
        cellArray[0].position.x = position.x - cell.size.width - cell.size.width / 10
        cellArray[2].position.x = position.x + cell.size.width + cell.size.width / 10
        
      return cellArray
        
    }
    
   
   
    
    @objc func createFigures () {
        
        let randomFigure = figureArray.randomElement()
        if let randomFigure = randomFigure {
            figure = SKSpriteNode(imageNamed: randomFigure)
            let sizeFigure = container.size.height / 2.5
            figure.size = CGSize(width: sizeFigure , height: sizeFigure)
            figure.position.x = CGFloat.random(in: (frame.minX + figure.size.width)..<(frame.maxX - figure.size.width))
            figure.run(SKAction.move(to: CGPoint(x: figure.position.x, y: -1000), duration:  figureSpeedInterval  ))
            figure.position.y = frame.maxY + figure.size.height
            figure.zPosition = 5
            figure.physicsBody = SKPhysicsBody(circleOfRadius: 2)
            figure.physicsBody?.isDynamic = true
            
            figure.physicsBody?.categoryBitMask = PhysicsCategories.figure
            figure.physicsBody?.contactTestBitMask = PhysicsCategories.cell
            figure.physicsBody?.collisionBitMask = 0
            figure.physicsBody?.usesPreciseCollisionDetection = true
            figure.name = randomFigure
            addChild(figure)

            
        }
       

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
           
                let touchLocation = touch.location(in: self)
            
                            let timeDuration = CGFloat(sqrt((touchLocation.x - container.position.x) * (touchLocation.x - container.position.x)) / 500 )
                            let moveContainer = SKAction.move(to: CGPoint(x: touchLocation.x, y: container.position.y), duration: timeDuration)
                            container.run(moveContainer)
              
            }
            
        }
    
    
    override func didEvaluateActions() {
        let arrayOfAllNameFigures  = Square + Ellipses + Triangle + ["bomb", "star"]
        for name in arrayOfAllNameFigures{
            enumerateChildNodes(withName: name) { figure, stop in
                let heightScreen = UIScreen.main.bounds.height
                if figure.position.y < -heightScreen{
                    figure.removeFromParent()
                }
            }
        }
         
        
    }
    
  
    func hideNotch(){
        guard (UIScreen.main.bounds.size.height) > 800 else {return}
        hidenRechtangle = SKSpriteNode(imageNamed: "hideRectangle")
        hidenRechtangle.size = CGSize(width: (UIScreen.main.bounds.size.width), height: 44)
        hidenRechtangle.position.y = (scene?.frame.maxY)! - hidenRechtangle.size.height / 2
        hidenRechtangle.zPosition = 1000
        addChild(hidenRechtangle)
        isHiddenBar = true
    }
    
    func createScoreBar() {
        scoreBar = SKSpriteNode(imageNamed: "scoreBar")
        scoreBar.size  = CGSize(width: UIScreen.main.bounds.size.width/1.3 , height: scoreBar.size.width / 5.1)
        scoreBar.zPosition = 99
        
        addChild(scoreBar)
        if isHiddenBar {
            scoreBar.position.y = hidenRechtangle.frame.minY - scoreBar.size.height / 2
        } else {
            scoreBar.position.y = (scene?.frame.maxY)! - scoreBar.size.height / 2
        }
        
        let scoreFrame = SKSpriteNode(imageNamed: "scoreFrame")
        scoreFrame.size  = CGSize(width: scoreBar.size.width / 2 , height: scoreFrame.size.width / 3.7)
        scoreFrame.zPosition = 100
        scoreFrame.position.y = 1
        scoreFrame.position.x = scoreBar.frame.maxX - scoreBar.size.width / 9 - scoreFrame.size.width / 2
        scoreBar.addChild(scoreFrame)
        
        scoreLable = SKLabelNode()
        scoreLable.text = String(SCORE)
        scoreLable.fontSize = 15
        scoreLable.fontColor = UIColor.white
        scoreLable.fontName = UIFont.fontNames(forFamilyName: "Montserrat")[0]
        scoreLable.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.center
        scoreLable.verticalAlignmentMode = SKLabelVerticalAlignmentMode.center
        scoreLable.zPosition = 101
        scoreFrame.addChild(scoreLable)
        
       
    }
    
    func heartsCount(count:Int){
        
        for _ in 1...3 {
        heart = SKSpriteNode(imageNamed: "heart")
        heart.size.height =  scoreBar.size.height / 3.3
        heart.size.width =  heart.size.width
        heart.position.y = scoreBar.frame.midY
        heart.position.x = scoreBar.frame.minX + scoreBar.size.width / 9
        heart.zPosition = 102
        
        
            array.append(heart)
        }
        var heartPos = scoreBar.frame.minX + scoreBar.size.width / 9
        for i in 0..<count{
            array[i].position.x = heartPos
            addChild(array[i])
            heartPos +=   array[i].size.width + array[i].size.width / 15
        }
    }
    
    func addScore (){
        SCORE += 1
    }

    func removeHeart(){
        CountOfHearts -= 1
    }

            
    func createBackground() {
        
        background = SKSpriteNode(imageNamed: "background")
        background.size = self.scene!.frame.size
        background.zPosition = -1
        
        
        addChild(background)
        
    }
    
}
