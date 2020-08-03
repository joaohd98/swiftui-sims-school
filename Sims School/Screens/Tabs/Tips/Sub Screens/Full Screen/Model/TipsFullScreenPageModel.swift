//
//  TipsFullScreenPageModel.swift
//  Sims School
//
//  Created by João Damazio on 02/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation


class TipsFullScreenPageModel: ObservableObject {
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
		self.currentMedia += value
		self.mediaRequest()
	}
	
	func mediaRequest() {
		let media = TipsMediasResponse(media: self.medias[self.currentMedia])
		
		TipsService.getMedia(media: media) { (url, image, video) in
			if let image = image {
				media.uiImage = image
				media.status = .success
				media.isVerticalImage(imageSource: image)
				
				self.medias[self.currentMedia] = media
			}
			else if let video = video {
				media.videoView = video
				media.status = .success
				media.isVerticalVideo(url: url!)
				
				self.medias[self.currentMedia] = media
			}
			else {
				media.status = .failed
			}
		}
	}
}
