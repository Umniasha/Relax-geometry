//
//  RecordsViewController.swift
//  Relax geometry
//
//  Created by Oleg Arnaut  on 11.08.2023.
//

import UIKit

class RecordsViewController: UIViewController {

    @IBOutlet weak var triangles: UIButton!
    @IBOutlet weak var circles: UIButton!
    @IBOutlet weak var squares: UIButton!
    @IBOutlet weak var bombs: UIButton!
    @IBOutlet weak var bonus: UIButton!
    @IBOutlet weak var erors: UIButton!
    @IBOutlet weak var fastest: UIButton!
    @IBOutlet weak var recordGame: UIButton!
    @IBOutlet weak var recordLbl: UILabel!
    
    
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        triangles.setTitle(String(caughtTriangles), for: .normal)
        triangles.setTitleColor(.green, for: .normal)
        circles.setTitle(String(caughtCircles), for: .normal)
        circles.setTitleColor(.green, for: .normal)
        squares.setTitle(String(caughtSquares), for: .normal)
        squares.setTitleColor(.green, for: .normal)
        bombs.setTitle(String(dodgedTheBomb), for: .normal)
        bombs.setTitleColor(.green, for: .normal)
        bonus.setTitle(String(caughtBonus), for: .normal)
        bonus.setTitleColor(.green, for: .normal)
        erors.setTitleColor(.green, for: .normal)
        erors.setTitle(String(errorsColour), for: .normal)
        fastest.setTitleColor(.green, for: .normal)
        fastest.setTitle(String(fastestLoss), for: .normal)
        fastest.setTitleColor(.green, for: .normal)
        recordGame.setTitle(String(recordScore), for: .normal)
        recordGame.setTitleColor(.green, for: .normal)
        recordLbl.text = String(recordScore)
        
    }
    

    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    
}
