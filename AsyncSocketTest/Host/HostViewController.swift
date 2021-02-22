import UIKit
import CocoaAsyncSocket

class HostViewController: UIViewController, HostPresenterDelegate {

    //MARK: - IBOutlets
    
    @IBOutlet weak var textView: UITextView!
    
    //MARK: - Variables
    
    private var hostPresenter = HostPresenter(hostService: HostWorker())
    
    //MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        hostPresenter.setDelegate(delegate: self)
        hostPresenter.startBroadcast()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    //MARK: - Setup UI
    
    func fnDefaultSetup() {
        
    }
    
    //MARK: - Button Actions
    
    @IBAction func btnBackClicked(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
        hostPresenter.removeSocket()
    }
    
    //MARK: - Other Methods
    
    func pushToGameView(objSock: GCDAsyncSocket) {
//        guard let gameVC = self.storyboard?.instantiateViewController(withIdentifier: "GameVC") as? GameVC else { return }
//        gameVC.isHost = true
//        gameVC.socket = objSock
//        self.navigationController?.pushViewController(gameVC, animated: true)
    }
    
    //MARK: - Webservices
    
    //MARK: - HostPresenter Delegate
    
    func netService(status: String) {
        textView.addTextToConsole(text: status)
    }
    
    func socket(status: String, socket: GCDAsyncSocket) {
        textView.addTextToConsole(text: status)
        if status.contains(Network.NETSERVICE.joinSoc) {
            self.pushToGameView(objSock: socket)
        }
    }
    
    func incomingValue(str: String) {
//        let iVC = self.navigationController?.viewControllers.filter {
//            return $0 is GameVC
//            }.first
//        guard let gameVc = iVC as? GameVC else {
//            return
//        }
//        gameVc.incomingActionWith(str: str)
    }

}
