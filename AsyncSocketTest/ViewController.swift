import UIKit

var logConsole = ""

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        logConsole = ""
    }
    
    // MARK: - IBAction
    @IBAction func hostBtn() {
        let hostVC = self.storyboard?.instantiateViewController(withIdentifier: "HostViewController") as! HostViewController
        self.navigationController?.pushViewController(hostVC, animated: true)
    }
    
    @IBAction func joinBtn() {
        let joinVC = self.storyboard?.instantiateViewController(withIdentifier: "JoinViewController") as! JoinViewController
        self.navigationController?.pushViewController(joinVC, animated: true)
    }


}

