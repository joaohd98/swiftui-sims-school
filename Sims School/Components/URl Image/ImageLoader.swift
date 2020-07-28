//
//  ImageLoader.swift
//  Sims School
//
//  Created by João Damazio on 25/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Combine
import Foundation

class ImageLoader: ObservableObject {
	static var cache = NSCache<NSString, UIImage>()
	@Published var url: URL?
	@Published var image: UIImage = UIImage(named: "placeholder")!
	@Published var hasError: Bool = false
	@Published var isLoading = true
	@Published var finished = false

	private var cancellable: URLSessionDataTask?

	init(url: URL?) {
		if let url = url{
			self.url = url
		
			if let cachedImage = ImageLoader.cache.object(forKey: url.absoluteString as NSString) {
				image = cachedImage
				self.isLoading.toggle()
				self.finished.toggle()
			}
				
			else {
				self.getImage()
			}
		}
	}
	
	deinit {
		self.cancel()
	}
	
	func retry()  {
		DispatchQueue.main.async {
			self.hasError = false
			self.isLoading = true
		}
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			self.getImage()
		})
	}
	
	private func getImage() {
		cancellable = URLSession.shared.dataTask(
			with: self.url!,
			completionHandler: { (data, response, error) in
				DispatchQueue.main.async {
					if data != nil{
						let image = UIImage(data: data!)!
						self.image = image
						self.setCache(image)
						self.finished.toggle()
					}
						
					else {
						self.hasError = true
					}
					
					self.isLoading = false
				}
			}
		)
		
		cancellable?.resume()
		
	}
	
	private func setCache(_ image: UIImage) {
		if let url = self.url,  {
			ImageLoader.cache.setObject(image, forKey: url.absoluteString as NSString)
		}
	}
	
	func cancel() {
		cancellable?.cancel()
	}
}
