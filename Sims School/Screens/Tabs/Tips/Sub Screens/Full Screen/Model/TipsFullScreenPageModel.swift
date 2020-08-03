//
//  TipsFullScreenPageModel.swift
//  Sims School
//
//  Created by João Damazio on 02/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation


class TipsFullScreenPageModel: ObservableObject {
	static var serialQueue = DispatchQueue(label: "TipsFullScreenPageModel")
	
	@Published var tip: TipsResponse
	@Published var medias: [TipsMediasResponse]
	@Published var isSliding: Bool
	@Published var currentSlide: Int
	@Published var isActual: Bool
	@Published var isDetectingPress = false
	@Published var currentMedia: Int
	
	init(tip: TipsResponse, isSliding: Bool, currentSlide: Int, isActual: Bool) {
		self.tip = tip
		self.medias = tip.medias
		self.isSliding = isSliding
		self.currentSlide = currentSlide
		self.isActual = isActual
		self.currentMedia = 0
	}
	
	func changeStatus (value: Int) {
		print("currentMedia", currentMedia)
		self.currentMedia += value
		DispatchQueue.global().asyncAfter(deadline: .now() + 1) {
			self.mediaRequest()
		}
	}
	
	func mediaRequest() {
		let index = self.currentMedia
		let media = TipsMediasResponse(media: self.medias[index])
		
		if media.uiImage != nil || media.videoView != nil {
			media.status = .success
			return
		}
		
		Self.serialQueue.sync {
			TipsService.getMedia(media: media) { (url, image, video) in
				if let image = image {
					
					media.uiImage = image
					media.status = .success
					media.isVerticalImage(imageSource: image)
					
					
					self.medias[index] = media
				}
				else if let video = video {
					media.videoView = video
					media.status = .success
					media.isVerticalVideo(url: url!)
					
					
					self.medias[index] = media
				}
				else {
					media.status = .failed
					self.medias[index] = media
				}
			}
		}
		
	}
}
