import UIKit
import CocoaAsyncSocket

class WelcomeViewController: UIViewController {
    // MARK: - IBOutlet
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var lblConnectedToPort: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var valueTF: UITextField!
    
    // MARK: - Variable
    var socket: GCDAsyncSocket?
    var isHost = false
    var arrCross = [Int]()
    var arrZero = [Int]()
    var ttx = ""
    var lastTurn = "x"
    var count = 1
//    var data = [ttx]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = logConsole
        lastTurn = isHost ? "x" : "o"
        lblConnectedToPort.text = isHost ? "Host connected to port \(String(describing: socket?.connectedPort))" : "Join connected to port \(String(describing: socket?.connectedPort))"
    }
    

    // MARK: - IBAction
    @IBAction func send() {
//        socket?.setDelegate(self, delegateQueue: DispatchQueue.main)
        incomingActionWith(str: valueTF.text ?? "")
        
        if isHost{
            //Even
            // 'X' tapped
            ttx = valueTF.text ?? ""
            self.sendValue(str: "Host #")
//            setCellWith(tag: indexPath.item, isIncoming: false)
        } else {
            //Odd
            // '0' tapped
            ttx = valueTF.text ?? ""
            self.sendValue(str: "Join # ")
//            setCellWith(tag: indexPath.item, isIncoming: false)
        }

        count += 1
        tableView.reloadData()
    }

}

extension WelcomeViewController {
    
    func sendValue(str: String) {
        let size = UInt(MemoryLayout<UInt64>.size)
        let data = Data(str.utf8)
        socket?.write(data, withTimeout: 30.0, tag: isHost ? 2 : 3)
        socket?.readData(toLength: size, withTimeout: 30.0, tag:  isHost ? 2 : 3)
        
    }
    
    func incomingActionWith(str: String) {
        var number: Int? {
            guard let strNum = str.components(separatedBy: "#").last?.trimmingCharacters(in: .whitespaces) else { return nil }
            return Int(strNum)
        }
        let num = number
        
        if isHost {
            if str.contains("Join #") && num != nil {
//                lblGameStatus.text = Constants.GAME.xsTurn
                print("Join make X on grid no. \(num!)")
                textView.addTextToConsole(text: "Join make X on grid no. \(num!)")
                setCellWith(tag: num!, isIncoming: true)
                
            }
        } else {
            if str.contains("Host #") && num != nil {
//                lblGameStatus.text = Constants.GAME.zerosTurn
                print("Host make 0 on grid no. \(num!)")
                textView.addTextToConsole(text: "Host make 0 on grid no. \(num!)")
                setCellWith(tag: num!, isIncoming: true)
            }
        }
        
        
    }
    
    func setCellWith(tag: Int, isIncoming: Bool) {
        let aCell = tableView.visibleCells.filter {
            return $0.tag == tag
        }.first
        if let cell = aCell as? WelcomeTableViewCell {
            if isIncoming {
                isHost ? setCellWith(cell: cell, turn: "0") : setCellWith(cell: cell, turn: "x")
            } else {
                isHost ? setCellWith(cell: cell, turn: "x") : setCellWith(cell: cell, turn: "0")
            }
        }
    }
    
    func setCellWith(cell: WelcomeTableViewCell, turn: String) {
        turn == "x" ? arrCross.append(cell.tag) : arrZero.append(cell.tag)
        lastTurn = turn
    }
    
    
}

extension WelcomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeTableViewCell", for: indexPath as IndexPath) as! WelcomeTableViewCell
        Cell.tag = indexPath.item
        Cell.title.text = ttx
        Cell.chanel.text = lastTurn
        print(Cell.tag)
        
        return Cell;
        
    }
}
