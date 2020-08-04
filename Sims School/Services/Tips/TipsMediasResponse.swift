//
//  TipsMediasResponse.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation

class TipsMediasResponse: ObservableObject {
	@Published var index: Int
	@Published var url: URL!
	@Published var image: String?
	@Published var video: String?
	@Published var videoDuration: Double
	@Published var uiImage: UIImage?
	@Published var videoView: VideoView?
	@Published var status: NetworkRequestStatus
	@Published var progress: Double
	@Published var isVerticalVideo: Bool
	@Published var isVerticalIMG: Bool
	
	init() {
		self.index = 0
		self.image = nil
		self.video = nil
		self.videoDuration = 0
		self.uiImage = nil
		self.videoView = nil
		self.status = .loading
		self.progress = 0
		self.isVerticalVideo = false
		self.isVerticalIMG = false
	}
	
	func isVerticalImage(imageSource: UIImage)  {
		let imageWidth = imageSource.size.width * imageSource.scale
		let imageHeight = imageSource.size.height * imageSource.scale
		
		self.isVerticalIMG = imageWidth < imageHeight
	}
	
	func isVerticalVideo(url: URL, completion: @escaping () -> Void) {
		let videoTrack = AVAsset(url: url)
		let assets =  ["tracks"]
		
		videoTrack.loadValuesAsynchronously(forKeys: assets) {
			let duration = videoTrack.duration.seconds
			let videoTrack = videoTrack.tracks(withMediaType: AVMediaType.video).first!
			let transformedVideoSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
			
			DispatchQueue.main.async {
				self.videoDuration = duration
				self.isVerticalVideo = abs(transformedVideoSize.width) < abs(transformedVideoSize.height)
				
				completion()
			}
		}
		
	}
	
	
}

extension TipsMediasResponse  {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.url = URL(string: dictionary["url"] as! String)!
		self.image =  dictionary["image"] as? String ?? nil
		self.video =  dictionary["video"] as? String ?? nil
	}
}
