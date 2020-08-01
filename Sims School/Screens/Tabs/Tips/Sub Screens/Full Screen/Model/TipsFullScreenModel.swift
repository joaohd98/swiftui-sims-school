//
//  TipsFullScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Foundation
import AVFoundation
import UIKit

class TipsFullScreenModel: ObservableObject {
	@Published var status: NetworkRequestStatus = .loading
	@Published var progress: CGFloat = 0
	@Published var isLongPressing: Bool = false
	@Published var uiImage: UIImage!
	@Published var videoView: VideoView!
	
	var isVerticalVideo: Bool = false
	var isVerticalIMG: Bool = false
	
	func initProps(media: TipsMediasResponse) {
		self.clearData()

		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			self.getMediaRequest(media: media)
		})
	}
	
	func clearData() {
		self.status = .loading
		self.progress = 0
		self.isLongPressing = false
		self.uiImage = nil
		self.videoView = nil
		self.isVerticalIMG = false
		self.isVerticalVideo = false
	}
	
	func getMediaRequest(media: TipsMediasResponse) {
		media.getMedia{ (url, image, video) in
			if let image = image {
				self.uiImage = image
				self.status = .success
				self.isVerticalImage(imageSource: image)
			}
			else if let video = video {
				self.videoView = video
				self.status = .success
				self.isVerticalVideo(url: url!)
			}
			else {
				self.status = .failed
			}
		}
	}
	
	func getImage() -> some View {
		if let uiImage = self.uiImage, !isVerticalIMG {
			return AnyView(getHorizontalImage(uiImage))
		}
			
		else if let videoView = self.videoView, !isVerticalVideo {
			return AnyView(getHorizontalVideo(videoView))
		}
			
		else {
			return AnyView(EmptyView())
		}
	}
	
	func getBackground() -> AnyView {
		if let uiImage = self.uiImage, isVerticalIMG {
			return AnyView(getVerticalImage(uiImage))
		}
			
		else if let videoView = self.videoView, isVerticalVideo {
			return AnyView(getVerticalVideo(videoView))
		}
			
		else {
			let backgroundColors = Gradient(colors: [
				Color(UIColor.hexStringToUIColor(hex: "#cccccc")),
				Color(UIColor.hexStringToUIColor(hex: "#e5e5e5"))
			])
				
			
			let gradient = LinearGradient(
				gradient: backgroundColors, startPoint: .top, endPoint: .bottom
			)
			
			return AnyView(gradient)
		}
		
	}
	private func isVerticalImage(imageSource: UIImage)  {
		let imageWidth = imageSource.size.width * imageSource.scale
		let imageHeight = imageSource.size.height * imageSource.scale
		
		self.isVerticalIMG = imageWidth < imageHeight
	}
	
	private func isVerticalVideo(url: URL) {
		let videoTrack = AVAsset(url: url).tracks(withMediaType: AVMediaType.video).first!
		
		let transformedVideoSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
		
		self.isVerticalVideo = abs(transformedVideoSize.width) < abs(transformedVideoSize.height)
	}
	
	private func getVerticalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight  - 20)
			.clipped()
	}
	
	private func getHorizontalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.scaledToFit()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 2)
			.clipped()
			.padding(.vertical, 10)
	}
	
	private func getVerticalVideo(_ videoView: VideoView) -> some View {
		videoView
			.frame(width: nil, height: UIScreen.screenHeight - 20, alignment: .center)
		
	}
	
	private func getHorizontalVideo(_ videoView: VideoView) -> some View {
		videoView
			.frame(width: nil, height: UIScreen.screenHeight / 3.5, alignment: .center)
	}
	
}

