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

    var scoreBar : UIImageView = UIImageView(image: UIImage(named: "scoreBar"))
    var scoreFrame : UIImageView = UIImageView(image: UIImage(named: "scoreFrame"))
    let  heart : UIImageView = UIImageView(image: UIImage(named: "heart"))
    
    @IBOutlet weak var hidenRechtangle: UIImageView!
    var isHiddenBar = false
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        hideNotch()
        createScoreBar ()
        //createScoreFrame()
        
        
        if let view = self.view as! SKView? {
            
            if let scene = SKScene(fileNamed: "GameScene") {
                
                scene.scaleMode = .aspectFill
                view.presentScene(scene)
                
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }
    
    func createScoreBar (){
        scoreBar.layer.zPosition = 10
        scoreBar.frame.size.width = view.bounds.width / 1.5
        scoreBar.frame.size.height = scoreBar.frame.size.width / 5
        scoreBar.layer.position.x = view.layer.position.x
        
        if isHiddenBar {
            scoreBar.layer.position.y += hidenRechtangle.bounds.size.height
        }
        view.addSubview(scoreBar)
        
        scoreFrame.layer.zPosition = 11
        scoreFrame.frame.size.width = scoreBar.frame.size.width / 2
        scoreFrame.frame.size.height = scoreFrame.frame.size.width / 3.7
        scoreFrame.layer.position.y = scoreBar.frame.size.height / 2
        scoreFrame.layer.position.x = scoreBar.frame.size.width / 2
        
        scoreBar.addSubview(scoreFrame)
        
//        let stackHearts = UIStackView()
//        stackHearts.alignment = .leading
//        stackHearts.distribution = .equalSpacing
//        let heartArray = [heart,heart,heart]
//        for heart in heartArray{
//            
//            heart.heightAnchor.constraint(equalToConstant: 10).isActive = true
//            heart.widthAnchor.constraint(equalToConstant: 10).isActive = true
//            stackHearts.addArrangedSubview(heart)
//           
//            
//        }
//        stackHearts.spacing = 20
//        stackHearts.translatesAutoresizingMaskIntoConstraints = false
//        scoreBar.addSubview(stackHearts)
//        stackHearts.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
//        stackHearts.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    

    
    func createStackScore(){
        
    }
    
    func hideNotch(){
        guard view.bounds.size.height > 800 else {return}
            isHiddenBar = true
            hidenRechtangle.isHidden = false
       
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
}
