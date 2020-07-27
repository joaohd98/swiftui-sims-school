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
	@Published var url: URL?
	@Published var image: UIImage = UIImage(named: "placeholder")!
	@Published var hasError: Bool = false
	@Published var isLoading = false
	
	private var cancellable: URLSessionDataTask?
	private var cache: ImageCache?
	
	init(cache: ImageCache?) {
		self.cache = cache
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
	
	func load(url: URL?){
		DispatchQueue.main.async {
			self.isLoading = true
			self.url = url
			self.getImage()
		}
	}
	
	private func getImage() {		
		if let image = cache?[self.url!] {
			self.image = image
			return
		}
		
		cancellable = URLSession.shared.dataTask(
			with: self.url!,
			completionHandler: { (data, response, error) in
				DispatchQueue.main.async {
					if data != nil{
						let image = UIImage(data: data!)!
						self.image = image
						self.cache(image)
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
	
	private func cache(_ image: UIImage?) {
		if let url = self.url {
			image.map { cache?[url] = $0 }
		}
	}
	
	func cancel() {
		cancellable?.cancel()
	}
}
