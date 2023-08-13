//
//  gameComponents.swift
//  Relax geometry
//
//  Created by Oleg Arnaut  on 08.08.2023.
//

import Foundation
import SpriteKit


let Ellipses = ["EllipseGreen", "EllipseRed", "EllipseWhite"]
let Square = ["SquareGreen",  "SquareRed",  "SquareWhite"]
let Triangle = ["TriangleGreen",  "TriangleRed", "TriangleWhite"]



let dict = [        "EllipseGreenContainer":"EllipseGreen",
                    "EllipseRedContainer":"EllipseRed",
                    "EllipseWhiteContainer":"EllipseWhite",
                    "SquareGreenContainer":"SquareGreen",
                    "SquareRedContainer":"SquareRed",
                    "SquareWhiteContainer":"SquareWhite",
                    "TriangleGreenContainer":"TriangleGreen",
                    "TriangleRedContainer":"TriangleRed",
                    "TriangleWhiteContainer":"TriangleWhite"]
var isDifficulty = false

var recordScore = 0
var fastestLoss = 0
var caughtTriangles = Int()
var caughtCircles = Int()
var caughtSquares = Int()
var dodgedTheBomb = Int()
var caughtBonus = Int()
var errorsColour = Int()


func saveData(){
    UserDefaults.standard.set(recordScore, forKey: "recordScore")
    UserDefaults.standard.set(fastestLoss, forKey: "fastestLoss")
    UserDefaults.standard.set(caughtTriangles, forKey: "caughtTriangles")
    UserDefaults.standard.set(caughtCircles, forKey: "caughtCircles")
    UserDefaults.standard.set(caughtSquares, forKey: "caughtSquares")
    UserDefaults.standard.set(dodgedTheBomb, forKey: "dodgedTheBomb")
    UserDefaults.standard.set(caughtBonus, forKey: "caughtBonus")
    UserDefaults.standard.set(errorsColour, forKey: "errorsColour")
    UserDefaults.standard.set(errorsColour, forKey: "isDifficulty")
    UserDefaults.standard.synchronize()
}

func loadData(){
    if let saveIsDifficulty = UserDefaults.standard.integer(forKey: "isDifficulty") as? Bool{
        isDifficulty = saveIsDifficulty
    } else {
        isDifficulty = false
    }
    if let saveRecordScore = UserDefaults.standard.integer(forKey: "recordScore") as? Int{
        recordScore = saveRecordScore
    } else {
        recordScore = 0
    }
    if let saveFastestLoss = UserDefaults.standard.integer(forKey: "fastestLoss") as? Int{
        fastestLoss = saveFastestLoss
    } else {
        fastestLoss = 0
    }
    if let saveCaughtTriangles = UserDefaults.standard.integer(forKey: "caughtTriangles") as? Int{
        caughtTriangles = saveCaughtTriangles
    } else {
        recordScore = 0
    }
    if let saveCaughtCircles = UserDefaults.standard.integer(forKey: "caughtCircles") as? Int{
        caughtCircles = saveCaughtCircles
    } else {
        caughtCircles = 0
    }
    if let saveCaughtSquares = UserDefaults.standard.integer(forKey: "caughtSquares") as? Int{
        caughtSquares = saveCaughtSquares
    } else {
        caughtSquares = 0
    }
    if let saveDodgedTheBomb = UserDefaults.standard.integer(forKey: "dodgedTheBomb") as? Int{
        dodgedTheBomb = saveDodgedTheBomb
    } else {
        dodgedTheBomb = 0
    }
    if let saveCaughtBonus = UserDefaults.standard.integer(forKey: "caughtBonus") as? Int{
        caughtBonus = saveCaughtBonus
    } else {
        caughtBonus = 0
    }
    if let saveErrorsColour = UserDefaults.standard.integer(forKey: "errorsColour") as? Int{
        errorsColour = saveErrorsColour
    } else {
        errorsColour = 0
    }
    
}


var containerFigureArray : [String] = keyDict()
var figureArray : [String] = valueDict()
func keyDict ()-> [String]{
    var array:[String] = []
for key in dict.keys{
    array.append(key)
}
    return array
}

func valueDict () -> [String]{
    var array:[String] = []
for value in dict.values{
    array.append(value)
}
    return array
}
struct PhysicsCategories {
    static let cell : UInt32 = 2
    static let figure : UInt32 = 1
   
}



