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
	@Published var isLoading = true
	@Published var finished = false

	init(url: URL?) {
		if let url = url{
			self.url = url
		
			if let cachedImage = URLSession.shared.getCacheIMG(url: url) {
				image = cachedImage.image
				self.isLoading.toggle()
				self.finished.toggle()
			}
				
			else {
				self.getImage()
			}
		}
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
		URLSession.shared.downloadImageAndCache(url: self.url) { image in
			if let image = image {
				self.image = image
				self.finished.toggle()
			}
			
			else {
				self.hasError = true
			}
			
			self.isLoading = false
		}
	}


}
