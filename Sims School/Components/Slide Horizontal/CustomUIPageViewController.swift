//
//  SlideHorizontal.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import SwiftUI
import UIKit
import Combine

struct CustomUIPageViewController: UIViewControllerRepresentable {
	var controllers: [UIViewController]
	@Binding var currentPage: Int
	var isInModal: Bool = false
	var currentPageCallBack: (Int) -> Void
	var isSlidingCallBack: (Bool) -> Void
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	func makeUIViewController(context: Context) -> UIPageViewController {
		let pageViewController = UIPageViewController(
			transitionStyle: .scroll,
			navigationOrientation: .horizontal
		)
		
		pageViewController.dataSource = context.coordinator
		pageViewController.delegate = context.coordinator
		
		if isInModal {
			pageViewController.view.backgroundColor = .black
		}
		
		else {
			pageViewController.setViewControllers(
			[controllers[currentPage]], direction: .forward, animated: true)
		}
	
		return pageViewController
	}
	
	func updateUIViewController(_ pageViewController: UIPageViewController, context: Context) {
		if isInModal {
			pageViewController.setViewControllers(
				[controllers[currentPage]], direction: .forward, animated: true)
		}
	}
	
	class Coordinator: NSObject, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
		var parent: CustomUIPageViewController
		
		init(_ pageViewController: CustomUIPageViewController) {
			self.parent = pageViewController
		}
		
		func pageViewController(
			_ pageViewController: UIPageViewController,
			viewControllerBefore viewController: UIViewController) -> UIViewController? {
			
			guard let index = parent.controllers.firstIndex(of: viewController) else {
				return nil
			}
			
			if index == 0 {
				if self.parent.isInModal {
					return nil
				}
				
				return parent.controllers.last
			}
			
			return parent.controllers[index - 1]
		}
		
		func pageViewController(
			_ pageViewController: UIPageViewController,
			viewControllerAfter viewController: UIViewController) -> UIViewController? {
			
			guard let index = parent.controllers.firstIndex(of: viewController) else {
				return nil
			}
			
			if index + 1 == parent.controllers.count {
				if self.parent.isInModal {
					return nil
				}
				
				return parent.controllers.first
			}
			
			return parent.controllers[index + 1]
		}
		
		func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
			self.parent.isSlidingCallBack(true)
		}
		
		func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
			if completed,
				let visibleViewController = pageViewController.viewControllers?.first,
				let index = parent.controllers.firstIndex(of: visibleViewController) {
				parent.currentPage = index
				
				self.parent.currentPageCallBack(index)
				
			}
					
			self.parent.isSlidingCallBack(false)
		}
		
	}
}
