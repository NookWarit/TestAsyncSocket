//
//  JoinPresenter.swift
//  AsyncSocketTest
//
//  Created by Foodstory on 22/2/2564 BE.
//

import Foundation
import CocoaAsyncSocket

protocol JoinPresenterDelegate: NSObjectProtocol {
    func netServiceBrowser(status: String)
    func socket(status: String, socket: GCDAsyncSocket)
    func netService(status: String)
    func reloadConnections(services: [NetService])
    func incomingValue(str: String)
}

class JoinPresenter: NSObject {
    
    private var joinService = JoinWorker()
    weak private var delegate: JoinPresenterDelegate?
    
    
    init(joinService: JoinWorker) {
        self.joinService = joinService
    }
    
    func setDelegate(delegate: JoinPresenterDelegate) {
        self.delegate = delegate
    }
    
    func startBrowsing() {

        joinService.startBrowsing(netServiceBlock: { (netServiceStatus) in
            self.delegate?.netService(status: netServiceStatus)
        }, netServiceBrowserBlock: { (netServiceBrowserStatus) in
            self.delegate?.netServiceBrowser(status: netServiceBrowserStatus)
        }, socketStatusBlock: { (socketStatus, objSocket) in
            self.delegate?.socket(status: socketStatus, socket: objSocket)
        }, reloadConnectionsBlock: { (netservices) in
            //Reload TableView With Bounjor Services
            self.delegate?.reloadConnections(services: netservices)
        }) { (incomingValue) in
            self.delegate?.incomingValue(str: incomingValue)
        }
        
    }
    
    func serviceSelected(service: NetService) {
        joinService.serviceSelected(service: service)
    }
    
    func stopBrowsing() {
        joinService.stopBrowsing()
    }
    
}
