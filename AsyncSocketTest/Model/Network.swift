import UIKit

class Network: NSObject {
    static let appdel = UIApplication.shared.delegate as! AppDelegate
    
    struct NETSERVICE {
        static let type = "_servicetype._tcp."
        static let name = "Nook Warit"
        static let domain = "local."
        static let host_port: UInt16 = 8080
        static let joinSoc = "Join_soc"
        static let hostSoc = "Host_soc"
        static let acceptedMsg = "Accepted"
        static let socketConnected = "SOCKET CONNECTION TESTED"
    }
}
