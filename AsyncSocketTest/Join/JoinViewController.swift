import UIKit
import CocoaAsyncSocket

class JoinViewController: UIViewController {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var tableView: UITableView!
    
    //MARK: - Variables
    
    private var joinPresenter = JoinPresenter(joinService: JoinWorker())
    var services: [NetService]?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        joinPresenter.setDelegate(delegate: self)
        joinPresenter.startBrowsing()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    func pushToWelcomeView(objSock: GCDAsyncSocket) {
        guard let welVC = self.storyboard?.instantiateViewController(withIdentifier: "WelcomeViewController") as? WelcomeViewController else { return }
        welVC.isHost = false
        welVC.socket = objSock
        self.navigationController?.pushViewController(welVC, animated: true)
    }
    

}

extension JoinViewController: JoinPresenterDelegate {
    func netServiceBrowser(status: String) {
        textView.text = status
    }
    
    func socket(status: String, socket: GCDAsyncSocket) {
        textView.addTextToConsole(text: status)
        if status.contains(Network.NETSERVICE.hostSoc) {
            self.pushToWelcomeView(objSock: socket)
        }
    }
    
    func netService(status: String) {
        textView.addTextToConsole(text: status)
    }
    
    func reloadConnections(services: [NetService]) {
        self.services = services
        tableView.reloadData()
    }
    
    func incomingValue(str: String) {
        let iVC = self.navigationController?.viewControllers.filter {
            return $0 is WelcomeViewController
            }.first
        guard let welcomeVc = iVC as? WelcomeViewController else {
            return
        }
        welcomeVc.incomingActionWith(str: str)
        if welcomeVc.tableView != nil {
            welcomeVc.tableView.reloadData()
        }
    }
    
    
}

extension JoinViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.services?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "JoinTableViewCell") as! JoinTableViewCell
        let service = self.services?[indexPath.row]
        cell.textLabel?.text = service?.name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let service = self.services?[indexPath.row] {
            joinPresenter.serviceSelected(service: service)
        }
    }
    
}
