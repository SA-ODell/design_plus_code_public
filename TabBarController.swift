//
//  TabBarViewController.swift
//  DesignCodeApp
//
//  Created by Meng To on 2017-07-30.
//  Copyright © 2017 Meng To. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {
    
    let presentMoreViewController = PresentMoreViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
        
        NotificationCenter.default.addObserver(self,
                                                selector: #selector(showHome),
                                                name: .ShowHome,
                                                object: nil)
    }
    
    @objc func showHome() {
        guard let navigationController = viewControllers?.first as? UINavigationController else {
            return
        }

        selectedIndex = 0
        if navigationController.childViewControllers.count > 1 {
            navigationController.popToRootViewController(animated: false)
        }

        guard let homeController = navigationController.childViewControllers.first as? HomeViewController else {
            return
        }
        
        homeController.presentedViewController?.dismiss(animated: false, completion: nil)
        homeController.purchaseButtonTapped(0)
    }
}

extension TabBarController: UITabBarControllerDelegate {
    func tabBarController(_ tabBarController: UITabBarController, animationControllerForTransitionFrom fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if toVC is MoreViewController {
            let toVC = toVC as! MoreViewController
            toVC.previousVC = fromVC
            return presentMoreViewController
        } else {
            return nil
        }
    }

    func tabBarController(_ tabBarController: UITabBarController,
                          shouldSelect viewController: UIViewController) -> Bool {

        inject(viewController: viewController)
        checkScrollingFor(viewController: viewController)
        return true
    }
    
    // MARK: - Injection
    func inject(viewController: UIViewController) {

        if let navigationController = viewController as? UINavigationController,
            let bookmarkViewController = navigationController.childViewControllers.first as? BookmarksTableViewController {
            guard bookmarkViewController.bookmarkLoader == nil else { return }
            var bookmarkLoadable: BookmarkLoadable
            if CommandLine.arguments.contains("--uitesting") {
                bookmarkLoadable = BookmarkLoaderMock()
            } else {
                bookmarkLoadable = BookmarkLoader()
            }
            bookmarkViewController.bookmarkLoader = bookmarkLoadable
        }
    }
    
    // MARK: - Scrolling position
    private func checkScrollingFor(viewController: UIViewController) {
        guard let index = viewControllers?.index(of: viewController) else { return }
        guard index == selectedIndex else { return }
        if let scrollabel: Scrollable = viewController.navigationOrRootAs() {
            scrollabel.scrollToTop()
        }
    }
}

