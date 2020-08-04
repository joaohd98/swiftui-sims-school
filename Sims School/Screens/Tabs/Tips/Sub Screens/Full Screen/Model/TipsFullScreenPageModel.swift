//
//  TipsFullScreenPageModel.swift
//  Sims School
//
//  Created by João Damazio on 02/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class TipsFullScreenPageModel: ObservableObject {	
	@Published var tip: TipsResponse
	@Published var medias: [TipsMediasResponse]
	@Published var currentMedia: Int
	@Binding var timer: Timer?

	init(tip: TipsResponse, timer: Binding<Timer?>) {
		self.tip = tip
		self.medias = tip.medias
		self.currentMedia = 0
		self._timer = timer
	}
	
	func removeTimer() {
		if let timer = self.timer {
			print("clear timer")
			timer.invalidate()
		}
	}
	
	func getActualMedia() -> TipsMediasResponse {
		self.medias[self.currentMedia]
	}
		

	func changeStatus (value: Int) {
		self.currentMedia += value
		self.mediaRequest()
	}
	
	func mediaRequest() {
		self.removeTimer()
		
		let index = self.currentMedia
		let media = self.medias[index]
		
		if media.uiImage != nil || media.videoView != nil {
			media.status = .success
			media.progress = 0
			self.medias[index] = media
			
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
