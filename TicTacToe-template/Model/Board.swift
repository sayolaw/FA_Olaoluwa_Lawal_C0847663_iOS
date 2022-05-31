//
//  Board.swift
//  TicTacToe-template
//
//  Created by Sayo Lawal on 2022-05-29.
//  Copyright © 2022 mohammadkiani. All rights reserved.
//

import Foundation

var boards:[Board]?
struct BoardM{
//    var crossArr:[String]
//    var notArr:[String]
    var turn:Bool = true
    var crossScore : Int = 0
    var noughtScore : Int = 0
    var gameState : Int = 0
    var lastMoveTag : Int = 0
  
    init(turn: Bool, crossScore:Int, noughtScore: Int, gameState: Int, lastMoveTag:Int){
        
//        self.crossArr = crossArr
//        self.notArr = notArr
        self.turn = turn
        self.crossScore = crossScore
        self.noughtScore = noughtScore
        self.gameState = gameState
        self.lastMoveTag = lastMoveTag
    }
}
