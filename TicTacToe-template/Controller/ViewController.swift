//
//  ViewController.swift
//  TicTacToe-template

// Had to use your template for assignment because i ran out of Apple bundles to create new projects

//  Created by Mohammad Kiani on 2020-06-08.
//  Copyright © 2020 mohammadkiani. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    
    var boards = [Board]()
    var turn = true

    let cross:UIImage? = UIImage(named:"cross.png")
    let not:UIImage? = UIImage(named:"nought.png")
    var crossScore = 0
    var lastmoveTag = 0
    var noughtScore = 0
    var gameState = 0
    var crossArr:Array = [String]()
    var notArr:Array = [String]()
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var managedContext:NSManagedObjectContext!
    
    func checkHorizontal(arr:[String],entered:String)->Bool{
        var checks = 0
        var dets:Array = [String]()
        if(Int(entered)! < 4){
            dets.append("1")
            dets.append("2")
            dets.append("3")
            
        }
        else if(Int(entered)! > 3 && Int(entered)! < 7){
            dets.append("4")
            dets.append("5")
            dets.append("6")
        }
        else{
            dets.append("7")
            dets.append("8")
            dets.append("9")
        }
        for i in dets {
            for j in arr{
                if(i==j){
                    checks+=1
                }
                else{
                    
                }
            }
        }
        if(checks==3){
            return true
        }
        return false
    }
    
    func checkVertical(arr:[String],entered:String)->Bool{
        var vchecks = 0
        var vdets:Array = [String]()
        if(entered == "1" || entered == "4" || entered == "7"){
            vdets.append("1")
            vdets.append("4")
            vdets.append("7")
            
        }
        else if(entered == "2" || entered == "5" || entered == "8"){
            vdets.append("2")
            vdets.append("5")
            vdets.append("8")
        }
        else{
            vdets.append("3")
            vdets.append("6")
            vdets.append("9")
        }
        for i in vdets {
            for j in arr{
                if(i==j){
                    vchecks+=1
                }
                else{
                    
                }
            }
        }
        if(vchecks==3){
            return true
        }
        return false
    }
    func checkDiagonal(arr:[String],entered:String)->Bool{
        var vchecks = 0
        var vdets:Array = [String]()
        if(entered == "1" || entered == "9"){
            vdets.append("1")
            vdets.append("5")
            vdets.append("9")
            
        }
        else if(entered == "3" || entered == "7"){
            vdets.append("3")
            vdets.append("5")
            vdets.append("7")
        }
        else if(entered == "5"){
            var newCheck = 1
            vdets.append("3")
            vdets.append("7")
            for x in vdets{
                for y in arr{
                    if(x==y){
                        newCheck+=1
                    }
                }

            }
            if(newCheck==3){
                vdets.append("5")
                
            }
            else{
                vdets = ["1","5","9"]
            }
            
        }
        print(vdets)
        for i in vdets {
            for j in arr{
                if(i==j){
                    vchecks+=1
                }
                else{
                    
                }
            }
        }
        if(vchecks==3){
            return true
        }
        return false
    }
    @IBOutlet weak var crossLabel: UILabel!
    @IBOutlet weak var noughtLabel: UILabel!
    
    @IBAction func newGame(_ sender: UIButton) {
        print("i was clicked")
        turn = true
        crossArr.removeAll()
        notArr.removeAll()
        gameState = 0
        self.loadView()
        crossLabel.text = String(crossScore)
        noughtLabel.text = String(noughtScore)
        
    }
//    func updateBoard(){
//        let board = BoardM(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag)
//    }
    func undoMove(){
        
        for thisButton in myButtons{
            print(thisButton.tag)
            if (thisButton.tag == lastmoveTag){
                print("i am here with \(lastmoveTag)")
                thisButton.setBackgroundImage(nil, for: .normal)
            }
        }
        if(!turn){
            crossArr.remove(at: crossArr.count-1)
           
        }
        else{
            notArr.remove(at: notArr.count-1)
        }
        turn = !turn
    }
    @IBAction func btnPressed(_ sender: UIButton) {
        guard let tag = (sender as? UIButton)?.tag else{
            return
        }
       

        if(gameState != 2){
            gameState = 1
            lastmoveTag = tag
            var check = checkField(position: tag)
//            updateBoard()
            if(turn && check){
                
                crossArr.append(String(tag))
                crossLabel.text = String(crossScore)
                appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))

              var state =  checkHorizontal(arr: crossArr, entered: String(tag))
                
                if(state){
                    
                    gameState = 2
                    crossScore += 1
                    
                    crossLabel.text = String(crossScore)
                    appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))
                    let alert = UIAlertController(title: "Game Over", message: "Cross Wins", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    state =  checkVertical(arr: crossArr, entered: String(tag))
                    if(state){
                        print("Cross Wins")
                        gameState = 2
                        crossScore += 1
                        crossLabel.text = String(crossScore)
                        appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))
                        let alert = UIAlertController(title: "Game Over", message: "Cross Wins", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        state =  checkDiagonal(arr: crossArr, entered: String(tag))
                        if(state){
                            print("Cross Wins")
                            gameState = 2
                            crossScore += 1
                            crossLabel.text = String(crossScore)
                            appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))
                            let alert = UIAlertController(title: "Game Over", message: "Cross Wins", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            sender.setBackgroundImage(cross, for: .normal)
                
            }
            else if(!turn && check){
                
                notArr.append(String(tag))
                crossLabel.text = String(crossScore)
                appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))
              var state =  checkHorizontal(arr: notArr, entered: String(tag))
                if(state){
                    print("Nought Wins")
                    gameState = 2
                    noughtScore += 1
                    noughtLabel.text = String(noughtScore)
                    appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))
                    let alert = UIAlertController(title: "Game Over", message: "Nought Wins", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
                else{
                    state =  checkVertical(arr: notArr, entered: String(tag))
                    if(state){
                        print("Nought Wins")
                        gameState = 2
                        noughtScore += 1
                        noughtLabel.text = String(noughtScore)
                        appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))
                        let alert = UIAlertController(title: "Game Over", message: "Nought Wins", preferredStyle: UIAlertController.Style.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                    else{
                        state =  checkDiagonal(arr: notArr, entered: String(tag))
                        if(state){
                            noughtScore += 1
                            noughtLabel.text = String(noughtScore)
                            gameState = 2
                            appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: lastmoveTag,crossMoves:crossArr.joined(separator: ","),noughtMoves:notArr.joined(separator: ","))
                            let alert = UIAlertController(title: "Game Over", message: "Nought Wins", preferredStyle: UIAlertController.Style.alert)
                            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                            
                        }
                    }
                }
                sender.setBackgroundImage(not, for: .normal)
            }
            if((notArr.count + crossArr.count) == 9){
                let alert = UIAlertController(title: "Game Over", message: "An Even Game", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                gameState = 2
            }
            if(check){
                turn = !turn}
            
        }
        
    }

    @IBOutlet var myButtons: [UIButton]!
    
    @IBAction func leftSwipe(_ sender: Any) {
        print("i was clicked")
        turn = true
        crossArr.removeAll()
        notArr.removeAll()
        gameState = 0
        self.loadView()
        crossLabel.text = String(crossScore)
        noughtLabel.text = String(noughtScore)
    }
//    @objc func tapped(sender:UITapGestureRecognizer){
//        if sender.state  == .ended{
//            print("i was clicked")
//            turn = true
//            crossArr.removeAll()
//            notArr.removeAll()
//            gameState = 0
//            self.loadView()
//            crossLabel.text = String(crossScore)
//            noughtLabel.text = String(noughtScore)
//            let tap = UITapGestureRecognizer(target: self, action: #selector(tapped))
//            tap.numberOfTapsRequired = 2
//            view.addGestureRecognizer(tap)
//        }
//    }
    @objc func swiped(_ gesture:UISwipeGestureRecognizer){
        if gesture.state == .ended{
        switch gesture.direction{
        case .left:
            print("i was clicked")
            turn = true
            crossArr.removeAll()
            notArr.removeAll()
            gameState = 0
            self.loadView()
            crossLabel.text = String(crossScore)
            noughtLabel.text = String(noughtScore)
            let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
            leftSwipe.direction = .left
            view.addGestureRecognizer(leftSwipe)
        case .right:
            print("i was clicked")
            turn = true
            crossArr.removeAll()
            notArr.removeAll()
            gameState = 0
            self.loadView()
            crossLabel.text = String(crossScore)
            noughtLabel.text = String(noughtScore)
        case .up:
            print("up swiped")
        case .down:
            print("down swiped")
        default:
            break
        }
        }
        
    }
    override func motionEnded(_ motion: UIEvent.EventSubtype, with event: UIEvent?) {
        undoMove()
    }
    func fixPositions(){
        turn = !(boards[0].turn)
        crossScore = Int(boards[0].crossScore)
        noughtScore = Int(boards[0].noughtScore)
        gameState = Int(boards[0].gameState)
        lastmoveTag = Int(boards[0].lastMoveTag)
        crossLabel.text = String(crossScore)
        noughtLabel.text = String(noughtScore)
        var xpositions = boards[0].crossMoves!.components(separatedBy: ",")
        for x in xpositions{
            for thisButton in myButtons{
                
                if (thisButton.tag == Int(x)){
                    
                    thisButton.setBackgroundImage(cross, for: .normal)
                    
                }
            }
        }
        crossArr = xpositions
        var opositions = boards[0].noughtMoves!.components(separatedBy: ",")
        for o in opositions{
            for thisButton in myButtons{
                
                if (thisButton.tag == Int(o)){
                    
                    thisButton.setBackgroundImage(not, for: .normal)
                    
                }
            }
        }
        crossArr = xpositions
        notArr = opositions
       
        
        
      
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        crossLabel.text = String(crossScore)
      
       
        noughtLabel.text = String(noughtScore)
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(swiped))
        leftSwipe.direction = .left
        view.addGestureRecognizer(leftSwipe)
        NotificationCenter.default.addObserver(self, selector: #selector(saveCoreData), name: UIApplication.willResignActiveNotification, object: nil)
        managedContext = appDelegate.persistentContainer.viewContext

        loadCoreData()
        if(boards.count>0){
            fixPositions()
        }

  
    }

    func appendMove(turn: Bool, crossScore: Int, noughtScore: Int, gameState: Int, lastMoveTag: Int,crossMoves:String,noughtMoves:String){
        print("here")
        let board = Board(context: managedContext)
        board.turn = turn
        board.crossMoves = crossMoves
        board.crossScore = Int16(crossScore)
        board.noughtScore = Int16(noughtScore)
        board.gameState = Int16(gameState)
        board.lastMoveTag = Int16(lastMoveTag)
        board.noughtMoves = noughtMoves
//        site.sayo = "Hello"
        if(boards.count>0){
            boards.removeLast()}
        boards.append(board)
        print(board)
        
    
      
        

        
    }
    @objc func saveCoreData(){
     clearCoreData()
        for board in boards{
            print(board)
            let boardEntity = NSEntityDescription.insertNewObject(forEntityName: "Board", into: managedContext)
            
            boardEntity.setValue(board.turn, forKey: "turn")
            boardEntity.setValue(board.crossScore, forKey: "crossScore")
            boardEntity.setValue(board.noughtScore, forKey: "noughtScore")
            boardEntity.setValue(board.gameState, forKey: "gameState")
            boardEntity.setValue(board.crossMoves, forKey: "crossMoves")
            boardEntity.setValue(board.noughtMoves, forKey: "noughtMoves")
            boardEntity.setValue(board.lastMoveTag, forKey: "lastMoveTag")
            
           
            
        }
        appDelegate.saveContext()
    }
    func checkField(position:Int)->Bool{
        for x in crossArr{
            if(x == String(position)){
                return false
            }
        }
        for o in notArr{
            if(o == String(position)){
                return false
            }
        }
        return true
        
    }
    func loadCoreData(){
        
        
       
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Board")
       
        do{
            let results = try managedContext.fetch(fetchRequest)
            
            if results is [NSManagedObject]{
         
               
                for result in (results as! [NSManagedObject]){
                    
                    let turn = result.value(forKey: "turn") as! Bool
                  
                    let crossScore = result.value(forKey: "crossScore") as! Int
                    let noughtScore = result.value(forKey: "noughtScore") as! Int
                    
                    let gameState = result.value(forKey: "gameState") as! Int
                    let last = result.value(forKey: "lastMoveTag") as! Int
                    let crossMoves = result.value(forKey: "crossMoves") as! String
                    let noughtMoves = result.value(forKey: "noughtMoves") as! String
                   
                  
                    appendMove(turn: turn, crossScore: crossScore, noughtScore: noughtScore, gameState: gameState, lastMoveTag: last,crossMoves: crossMoves,noughtMoves: noughtMoves)
                   
                }
                
            }
        } catch{
            print(error)
        }
    }
    func clearCoreData(){
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Board")
        do{
            let results = try managedContext.fetch(fetchRequest)
                for result in (results as! [NSManagedObject]){
                    if let managedObject = result as? NSManagedObject{
                        managedContext.delete(managedObject)
                }
            }
        } catch{
            print(error)
        }
    }

}

