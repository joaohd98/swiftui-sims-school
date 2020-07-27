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
	@Published var image: UIImage?
	@Published var url: URL?
	@Published var hasError: Bool = false
	
	private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
	
	private var cancellable: URLSessionDataTask?
	private var cache: ImageCache?
	private var isLoading = false
	
	init(cache: ImageCache?) {
		self.cache = cache
	}
	
	deinit {
		self.cancel()
	}
	
	
	func retry()  {
		self.getImage()
		self.hasError = false
	}
	
	func load(url: URL?){
		self.url = url
		self.getImage()
	}
	
	private func getImage() {
		guard !isLoading else { return }
		
		if let image = cache?[self.url!] {
			self.image = image
			return
		}
		
		cancellable = URLSession.shared.dataTask(
			with: self.url!,
			completionHandler: { (data, response, error) in
				DispatchQueue.main.async {
					if data != nil{
						let image = UIImage(data: data!)
						self.image = image
						self.cache(image)
					}
						
					else {
						self.hasError = true
						self.cancellable?.cancel()
					}
				}
			}
		)
		
		cancellable?.resume()
		
		//		cancellable = URLSession.shared.dataTaskPublisher(for: self.url!)
		//			.subscribe(on: Self.imageProcessingQueue)
		//			.map { UIImage(data: $0.data) }
		//			.mapError { error -> Error in
		//				DispatchQueue.main.async {
		//					if !self.hasError {
		//						self.hasError.toggle()
		//					}
		//				}
		//
		//				return error
		//			}
		//			.handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
		//						  receiveOutput: { [weak self] in self?.cache($0) },
		//						  receiveCompletion: { [weak self] _ in self?.onFinish() },
		//						  receiveCancel: { [weak self] in self?.onFinish() })
		//			.receive(on: DispatchQueue.main)
		//			.replaceError(with: nil)
		//			.assign(to: \.image, on: self)
		
	}
	
	private func onStart() {
		isLoading = true
		
		DispatchQueue.main.async {
			if self.hasError {
				self.hasError.toggle()
			}
		}
	}
	
	private func onFinish() {
		isLoading = false
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
