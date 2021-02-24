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
    var value = ""
    var count = 1
    
    var data = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.text = logConsole
        lblConnectedToPort.text = isHost ? "Host connected to port \(String(describing: socket?.connectedPort))" : "Join connected to port \(String(describing: socket?.connectedPort))"
    }
    

    // MARK: - IBAction
    @IBAction func send() {
        self.sendValue(str:"\(valueTF.text ?? "")")
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
        ttx = str
        value += ttx
    }
    
}

extension WelcomeViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let Cell = tableView.dequeueReusableCell(withIdentifier: "WelcomeTableViewCell", for: indexPath as IndexPath) as! WelcomeTableViewCell
        Cell.title.text = value
        
        return Cell;
        
    }
}
