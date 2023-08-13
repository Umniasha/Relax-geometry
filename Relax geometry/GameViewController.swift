//
//  GameViewController.swift
//  Relax geometry
//
//  Created by Oleg Arnaut  on 07.08.2023.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {


    var gameScene : GameScene!
    

    @IBOutlet weak var homeButton: UIButton!
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var heartImage: UIImageView!
    
    @IBOutlet weak var buttonStackView: UIStackView!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
      

        
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "GameScene") {
                
                scene.scaleMode = .resizeFill
                
                gameScene = scene as! GameScene
                gameScene.gameViewController = self
                view.presentScene(scene)
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
            view.showsPhysics = true
          
        }
    }
    


    @IBAction func toHome(_ sender: Any) {
        gameScene.gameOver()
    }
    
  
    @IBAction func tryAggain(_ sender: Any) {
        gameScene.playGame()
        homeButton.isHidden = false
        bgImage.isHidden = true
        buttonStackView.isHidden = true
        heartImage.isHidden = true
    }
    
       
    
    
   

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .portrait
        } else {
            return .portrait
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    
    
    deinit{
        print("deinit")
    }
  
        
    
}
