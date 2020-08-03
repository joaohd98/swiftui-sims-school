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
	@Published var changedSlide: Bool
	@Binding var nav: SlideHorizontalNav
	@Binding var isDetectingPress: Bool
	var timer: Timer?
	
	init(tip: TipsResponse, nav: Binding<SlideHorizontalNav>, isDetectingPress: Binding<Bool>) {
		self.tip = tip
		self.medias = tip.medias
		self._nav = nav
		self._isDetectingPress = isDetectingPress
		self.currentMedia = 0
		self.changedSlide = false
	}
	
	func setTimeImage() {
		var seconds = 5.0
		let interval = 0.1
		let valueProgress = (1 / seconds) / 10
		
		self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
			
			if true {
				let media = self.medias[self.currentMedia]
				
				seconds -= interval
				media.progress += valueProgress
				
				if seconds < 0 {
					timer.invalidate()
					
					//					if self.currentMedia + 1 >= self.medias.count {
					//						self.nav = .next
					//					}
					//					else {
					//						self.currentMedia += 1
					//					}
				}
				
				self.medias[self.currentMedia] = media
			}
		}
	}
	
	func setTimeVideo() {
		let media = self.medias[self.currentMedia]
		
		var seconds = media.videoDuration
		let interval = 0.1
		let valueProgress = (1 / seconds) / 10
		
		self.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
			
			if true {
				let media = self.medias[self.currentMedia]
				
				seconds -= interval
				media.progress += valueProgress
								
				if seconds <= 0 {
					timer.invalidate()
					
					//					if self.currentMedia + 1 >= self.medias.count {
					//						self.nav = .next
					//					}
					//					else {
					//						self.currentMedia += 1
					//					}
					
				}
				
				self.medias[self.currentMedia] = media
			}
		}
	}
	
	
	func changeStatus (value: Int) {
		self.currentMedia += value
		self.mediaRequest()
	}
	
	func mediaRequest() {
		if let timer = self.timer {
			timer.invalidate()
		}
		
		let index = self.currentMedia
		let media = self.medias[index]
		
		if media.uiImage != nil || media.videoView != nil {
			media.status = .success
			media.progress = 0
			self.medias[index] = media
			
			if media.image != nil {
				self.setTimeVideo()
			}
			else {
				self.setTimeImage()
			}
			
			return
		}
		
		media.progress = 0
		media.status = .loading
		self.medias[index] = media
		
		let serialQueue = DispatchQueue(label: "TipsFullScreenPageModel\(self.tip.name)")
		serialQueue.sync {
			TipsService.getMedia(media: media, hasPause: self.$isDetectingPress ) { (url, image, video) in
				if let image = image {
					
					media.uiImage = image
					media.status = .success
					media.isVerticalImage(imageSource: image)
					
					self.medias[index] = media
					self.setTimeImage()
					
				}
				else if let video = video {
					media.videoView = video
					
					media.isVerticalVideo(url: url!) {
						media.status = .success
						self.medias[index] = media
						self.setTimeVideo()
					}
					
				}
				else {
					let url = URL(string: "https://bit.ly/swswift")!
					
					media.videoView = VideoView(
						videoURL: url,
						hasToPause: false
					)
					
					media.isVerticalVideo(url: url) {
						media.status = .success
						self.medias[index] = media
						self.setTimeVideo()
					}
					
					//					media.status = .failed
					//					self.medias[index] = media
				}
				
				self.tip.medias = self.medias
				
			}
		}
		
	}
}
