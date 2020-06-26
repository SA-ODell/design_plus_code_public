//
//  Configuration.swift
//  DesignCodeApp
//
//  Created by Meng To on 2017-08-11.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit

public func spring3DCoverFlow(frame: CGRect) -> CATransform3D {
    let degrees = Double((-frame.origin.x) / 10)
    
    var scale = (1000 - (frame.origin.x - 200)) / 1000
    if scale > 1 {
        scale = 1
    }
    if scale < 0.9 {
        scale = 0.9
    }
    
    let scale3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    return CATransform3DConcat(spring3DRotate(degrees: degrees), scale3D)
}

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func showSectionUnavailableAlert() {
        showAlert(title: "Section not available",
                  message: "This section is not available yet.")
    }
    
    func showFeatureUnavailableAlert() {
        showAlert(title: "Feature not available",
                  message: "This feature is not available yet.")
    }
    
    func showLoginAlert() {
        showAlert(title: "Content not available",
                  message: "Please log in to access this content.")
    }
    
    func showNoInternetConnectionAlert() {
        showAlert(title: "No internet conenction",
                  message: "Network connection is needed in order to perform this action.")
    }
    
    func showPurchaseUnavailable() {
        showAlert(title: "Purchases are not yet enabled",
                  message: "Purchases will be enabled once the app is launched on the App Store.")
    }
    
    func showPlanExpiredAlert() {
        showAlert(title: "Your plan has expired",
                  message: "You'll be able to use the app with limited content. Please head over to Subscriptions to update your plan.")
    }
    
    func showAlert(title: String, message: String, alertActions: [AlertAction]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in alertActions {
            let alertAction = UIAlertAction(title: action.title, style: action.style, handler: { _ in
                action.handler?()
            })
            alert.addAction(alertAction)
        }
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}

func randomString(length: Int) -> String {
    
    let letters : NSString = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
    let len = UInt32(letters.length)
    
    var randomString = ""
    
    for _ in 0 ..< length {
        let rand = arc4random_uniform(len)
        var nextChar = letters.character(at: Int(rand))
        randomString += NSString(characters: &nextChar, length: 1) as String
    }
    
    return randomString
}

public func spring3DCoverFlowLarge(frame: CGRect) -> CATransform3D {
    
    let degrees = Double((-frame.origin.x) / 40)
    
    var scale = (1000 - (frame.origin.x - 0)) / 1000
    if scale > 1.0 {
        scale = 1.0
    }
    if scale < 0.9 {
        scale = 0.9
    }
    
    let scale3D = CATransform3DScale(CATransform3DIdentity, scale, scale, 1)
    return CATransform3DConcat(spring3DRotate(degrees: degrees), scale3D)
}

struct SpringDialog {
    static func animateClose(dialogView: UIView, backgroundView: UIVisualEffectView, completion: @escaping() -> Void) {
        UIView.animate(withDuration: 0.5, animations: {
            backgroundView.alpha = 0
            dialogView.alpha = 0
            let degrees = CGFloat(Int(arc4random_uniform(60)) - 30)
            let rotation = CGAffineTransform(rotationAngle: degreesToRadians(degrees: degrees))
            let translation = CGAffineTransform(translationX: 0, y: 500)
            dialogView.transform = rotation.concatenating(translation)
        }) { (finished) in
            completion()
            delay(delay: 0.5, closure: {
                backgroundView.alpha = 1
                dialogView.transform = CGAffineTransform.identity
            })
        }
    }
    
    static func animateAppear(dialogView: UIView) {
        let translation = CGAffineTransform(translationX: 0, y: 300)
        let degrees = CGFloat(Int(arc4random_uniform(60)) - 30)
        let rotation = CGAffineTransform(rotationAngle: degreesToRadians(degrees: degrees))
        dialogView.transform = translation.concatenating(rotation)
        
        let animator = UIViewPropertyAnimator(duration: 0.5, dampingRatio: 0.9) {
            dialogView.alpha = 1
            dialogView.transform = CGAffineTransform.identity
        }
        animator.startAnimation()
    }
}

func getBackground(section: Section) -> String {
    return section.slug
}

extension UILabel {
    func animateToNumber(_ number: Int, duration: Double) {
        guard number > 0 else { return }
        DispatchQueue.global().async {
            for index in 0...number {
                let sleepTime = UInt32(duration/Double(number) * 1000000.0)
                usleep(sleepTime)
                DispatchQueue.main.async {
                    self.text = "\(index)%"
                }
            }
        }
    }
}

func getContentBackground(content: Content) -> String {
    var background = ""
    if content.section_id >= 22 {
        background = "Chapter3"
    } else if content.section_id == 11 {
        background = "sketch"
    } else {
        background = "chapter1"
    }
    return "https://designcode.io/cloud/\(background)/\(content.image)"
}

func stringToDate(date: String, format: String) -> Date? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT+0:00")
    let date = dateFormatter.date(from: date)
    return date
}

public func appHasWideScreenForView(_ view: UIView) -> Bool {
    let width = view.bounds.width
    if width > 700 {
        return true
    } else {
        return false
    }
}

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

public func appHasBigScreenForView(_ view: UIView) -> Bool {
    if view.bounds.width > 700 && view.bounds.height > 700 {
        return true
    } else {
        return false
    }
}

public func isiPhoneXForView(_ view: UIView) -> Bool {
    if view.bounds.width == 812 || view.bounds.height == 812 {
        return true
    } else {
        return false
    }
}

public func getMediaUrl(chapterId: Int, mediaFile: String) -> String {
    var url = "https://designcode.io/cloud/ios11/\(mediaFile)"
    if chapterId == 2 {
        url = "https://designcode.io/cloud/sketch4/\(mediaFile)"
    } else if chapterId == 3 || chapterId == 4 {
        url = "https://designcode.io/cloud/swift4/\(mediaFile)"
    }
    return url
}

/**
 *  Perform a throwing expression, and throw a custom error in case the expression threw
 *
 *  - parameter expression: The expression to execute
 *  - parameter error: The custom error to throw instead of the expression's error
 *  - throws: The given error
 *  - returns: The return value of the given expression
 */
func perform<T>(_ expression: @autoclosure () throws -> T, orThrow error: Error) throws -> T {
    do {
        return try expression()
    } catch _ {
        throw error
    }
}
