//
//  SettingsViewController.swift
//  Relax geometry
//
//  Created by Oleg Arnaut  on 11.08.2023.
//

import UIKit

class SettingsViewController: UIViewController {
   
    
    @IBOutlet weak var offDifficulty: UILabel!
    @IBOutlet weak var onDifficulty: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        if isDifficulty{
            onDifficulty.textColor = .systemGreen
            offDifficulty.textColor = .white
        } else {
            onDifficulty.textColor = .white
            offDifficulty.textColor = .systemGreen
        }
    }
    

    @IBAction func SetDifficulty(_ sender: Any) {
       
        
        
        isDifficulty = !isDifficulty
        if isDifficulty{
            onDifficulty.textColor = .systemGreen
            offDifficulty.textColor = .white
        } else {
            onDifficulty.textColor = .white
            offDifficulty.textColor = .systemGreen
        }
    }
    
    @IBAction  func toSetVC( _ unwindSegue: UIStoryboardSegue){
           
           
        }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override var prefersHomeIndicatorAutoHidden: Bool{
        return true
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
