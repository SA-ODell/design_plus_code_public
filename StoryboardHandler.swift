//
//  StoryboardHandler.swift
//  DesignCodeApp
//
//  Created by Marcos Griselli on 12/8/17.
//  Copyright © 2017 Meng To. All rights reserved.
//

import Foundation
import UIKit

protocol StoryboardHandler {
    static var identifier: String { get }
}

extension StoryboardHandler where Self: UIViewController {
    static var identifier: String {
        return String(describing: self)
    }
}

extension UIViewController : StoryboardHandler {}

extension UIStoryboard {
    
    enum Storyboard: String {
        case main
        case more
        case embed
        case dialog
        case section
        
        var filename: String {
            return rawValue.capitalized
        }
    }

    // MARK: - Init
    convenience init(storyboard: Storyboard, bundle: Bundle? = nil) {
        self.init(name: storyboard.filename, bundle: bundle)
    }
    
    
    // MARK: - Class Functions
    class func storyboard(_ storyboard: Storyboard, bundle: Bundle? = nil) -> UIStoryboard {
        return UIStoryboard(name: storyboard.filename, bundle: bundle)
    }
    
    // MARK: - View Controller Instantiation
    func instantiateViewController<T: UIViewController>() -> T {
        guard let viewController = self.instantiateViewController(withIdentifier: T.identifier) as? T else {
            fatalError("ViewController with identifier: \(T.identifier) not found.")
        }
        return viewController
    }
}
