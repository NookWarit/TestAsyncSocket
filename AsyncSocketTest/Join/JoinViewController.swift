//
//  JoinViewController.swift
//  AsyncSocketTest
//
//  Created by Foodstory on 22/2/2564 BE.
//

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
    

}

extension JoinViewController: JoinPresenterDelegate {
    func netServiceBrowser(status: String) {
        textView.text = status
    }
    
    func socket(status: String, socket: GCDAsyncSocket) {
        textView.addTextToConsole(text: status)
        if status.contains(Network.NETSERVICE.hostSoc) {
//            self.pushToGameView(objSock: socket)
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
//        let iVC = self.navigationController?.viewControllers.filter {
//            return $0 is GameVC
//            }.first
//        guard let gameVc = iVC as? GameVC else {
//            return
//        }
//        gameVc.incomingActionWith(str: str)
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
