import UIKit

extension UITextView {
    
    func addTextToConsole(text: String) {
        logConsole = logConsole + "\n \n" + text
        self.text = logConsole
        let btm = NSMakeRange(self.text.lengthOfBytes(using: String.Encoding.utf8), 0)
        self.scrollRangeToVisible(btm)
    }
    
}
