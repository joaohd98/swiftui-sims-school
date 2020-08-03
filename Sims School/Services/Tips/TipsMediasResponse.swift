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
	@Published var url: URL!
	@Published var image: String?
	@Published var video: String?
	@Published var uiImage: UIImage?
	@Published var videoView: VideoView?
	@Published var status: NetworkRequestStatus
	@Published var progress: CGFloat
	@Published var isVerticalVideo: Bool
	@Published var isVerticalIMG: Bool
	
	init() {
		self.image = nil
		self.video = nil
		self.uiImage = nil
		self.videoView = nil
		self.status = .loading
		self.progress = 0
		self.isVerticalVideo = false
		self.isVerticalIMG = false
	}
	
	init(media: TipsMediasResponse) {
		self.url = media.url
		self.image = media.image
		self.video = media.video
		self.uiImage = media.uiImage
		self.videoView = media.videoView
		self.status = media.status
		self.progress = media.progress
		self.isVerticalVideo = media.isVerticalVideo
		self.isVerticalIMG = media.isVerticalIMG
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
			let videoTrack = videoTrack.tracks(withMediaType: AVMediaType.video).first!
			let transformedVideoSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
			
			DispatchQueue.main.async {
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
