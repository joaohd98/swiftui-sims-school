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

	private var cancellable: AnyCancellable?
	private var cache: ImageCache?
	private(set) var isLoading = false
	private static let imageProcessingQueue = DispatchQueue(label: "image-processing")
	
	init(cache: ImageCache?) {
		self.cache = cache
	}
	
	deinit {
		cancellable?.cancel()
	}
	
	func load(url: URL) {
		guard !isLoading else { return }
		self.url = url
		
		if let image = cache?[url] {
			self.image = image
			return
		}
		
		cancellable = URLSession.shared.dataTaskPublisher(for: url)
			.subscribe(on: Self.imageProcessingQueue)
			.map { UIImage(data: $0.data) }
			.replaceError(with: nil)
			.handleEvents(receiveSubscription: { [weak self] _ in self?.onStart() },
						  receiveOutput: { [weak self] in self?.cache($0) },
						  receiveCompletion: { [weak self] _ in self?.onFinish() },
						  receiveCancel: { [weak self] in self?.onFinish() })
			.receive(on: DispatchQueue.main)
			.assign(to: \.image, on: self)
	}
	
	private func onStart() {
		isLoading = true
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
