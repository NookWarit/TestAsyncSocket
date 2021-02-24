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
    
 
//    @IBAction func btnBackClicked(_ sender: Any) {
//        self.navigationController?.popViewController(animated: true)
//        hostPresenter.removeSocket()
//    }
    
    
    //MARK: - Other Methods
    
    func pushToWelcomeView(objSock: GCDAsyncSocket) {
        guard let welVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else { return }
        welVC.isHost = true
        welVC.socket = objSock
        self.navigationController?.pushViewController(welVC, animated: true)
    }
    
    //MARK: - Webservices
    
    //MARK: - HostPresenter Delegate
    
    func netService(status: String) {
        textView.addTextToConsole(text: status)
    }
    
    func socket(status: String, socket: GCDAsyncSocket) {
        textView.addTextToConsole(text: status)
        if status.contains(Network.NETSERVICE.joinSoc) {
            self.pushToWelcomeView(objSock: socket)
        }
    }
    
    func incomingValue(str: String) {
        let iVC = self.navigationController?.viewControllers.filter {
            return $0 is WelcomeViewController
            }.first
        guard let welcomeVc = iVC as? WelcomeViewController else {
            return
        }
        welcomeVc.incomingActionWith(str: str)
    }

}
