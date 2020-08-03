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
	@Published var isDetectingPress = false
	@Published var currentMedia: Int
	@Published var changedSlide: Bool

	init(tip: TipsResponse) {
		self.tip = tip
		self.medias = tip.medias
		self.currentMedia = 0
		self.changedSlide = false
	}
	
	func changeStatus (value: Int) {
		self.currentMedia += value
		self.mediaRequest()
	}
	
	func mediaRequest() {
		let index = self.currentMedia
		let media = self.medias[index]
				
		if media.uiImage != nil || media.videoView != nil {
			media.status = .success
			return
		}
		
		let serialQueue = DispatchQueue(label: "TipsFullScreenPageModel\(self.tip.name)")
		
		serialQueue.sync {
			TipsService.getMedia(media: media) { (url, image, video) in
				if let image = image {
					
					media.uiImage = image
					media.status = .success
					media.isVerticalImage(imageSource: image)
					
					
					self.medias[index] = media
				}
				else if let video = video {
					media.videoView = video
					
					media.isVerticalVideo(url: url!) {
						media.status = .success
						self.medias[index] = media
					}
					
				}
				else {
					media.status = .failed
					self.medias[index] = media
				}
				
				self.tip.medias = self.medias
				
			}
		}
		
	}
}
