//
//  NextPreviousUiPageViewController.swift
//  Sims School
//
//  Created by João Damazio on 03/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit

extension UIPageViewController {
	
	func goToNextPage() {
		guard let currentViewController = self.viewControllers?.first else { return }
		guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController ) else { return }
		setViewControllers([nextViewController], direction: .forward, animated: false, completion: nil)
	}
	
	func goToPreviousPage() {
		guard let currentViewController = self.viewControllers?.first else { return }
		guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return
		}
		setViewControllers([previousViewController], direction: .reverse, animated: false, completion: nil)
	}
	
}
