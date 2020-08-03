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
		self.view.isUserInteractionEnabled = false
		
		guard let currentViewController = self.viewControllers?.first else { return }
		guard let nextViewController = dataSource?.pageViewController(self, viewControllerAfter: currentViewController ) else {
			return
		}
				
		setViewControllers([nextViewController], direction: .forward, animated: true, completion: { _ in
			self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)

			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				self.view.isUserInteractionEnabled = true
			}
		})
	}
	
	func goToPreviousPage() {
		self.view.isUserInteractionEnabled = false

		guard let currentViewController = self.viewControllers?.first else { return }
		guard let previousViewController = dataSource?.pageViewController( self, viewControllerBefore: currentViewController ) else { return
		}
		
		setViewControllers([previousViewController], direction: .reverse, animated: true, completion: { _ in
			self.delegate?.pageViewController?(self, didFinishAnimating: true, previousViewControllers: [], transitionCompleted: true)

			DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
				self.view.isUserInteractionEnabled = true
			}
		})

	}
	
}
