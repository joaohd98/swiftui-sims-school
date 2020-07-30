//
//  TipsScreenFullScreenImage.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import AVKit

struct TipsScreenFullScreenImage: View {
	@Binding var tips: [TipsResponse]
	@Binding var fullScreenIndex: (tips: Int, medias: Int)
	@State var progress: Int = 0
	@Environment(\.presentationMode) var presentationMode

//	func isVerticalImage() -> Bool {
//		let imageSource = UIImage(named: self.statusIMG)!
//		let screenHeight = UIScreen.screenHeight
//		
//		let imageWidth = imageSource.size.width * imageSource.scale
//		let imageHeight = imageSource.size.height * imageSource.scale
//		
//		return screenHeight < imageHeight && imageHeight > imageWidth / 2
//	}
//	
//	func isVerticalVideo() -> Bool {
//
//		let videoTrack = AVAsset(url: self.urlVideo).tracks(withMediaType: AVMediaType.video).first!
//		
//		let transformedVideoSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
//			
//		return abs(transformedVideoSize.width) < abs(transformedVideoSize.height)
//	}
	
	func progressBar(tip: TipsResponse) -> some View {
		let progressValue = CGFloat.random(in: 0 ... 0.5)
		let statusQuantity = tip.medias.count
		let padding = CGFloat(10)
		let size = UIScreen.screenWidth / CGFloat(statusQuantity) - padding
		
		return (
			HStack {
				ForEach(0..<statusQuantity) { index in
					ZStack(alignment: .leading) {
						Rectangle()
							.frame(width: size, height: 6, alignment: .center)
							.opacity(0.3)
							.foregroundColor(Color.gray)
						
						Rectangle()
							.frame(
								width: min(CGFloat(progressValue) * size, size),
								height: 6,
								alignment: .leading
						)
							.foregroundColor(Color.blue)
							.animation(.linear)
					}
					.cornerRadius(45.0)
				}
			}
			.padding(.vertical, 10)
		)
	}
	
	func backButton(tip: TipsResponse) -> some View {
		Button(action: {
			self.presentationMode.wrappedValue.dismiss()
		}) {
			HStack(spacing: 10) {
				Image(systemName: "chevron.left")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 20, height: 20, alignment: .center)
					.foregroundColor(Color.white)
				Text(tip.name)
					.foregroundColor(Color.white)
					.font(.system(size: 14, weight: .semibold))
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.vertical, 10)
			.padding(.horizontal, 20)

		}
	}
	
//	func getVerticalImage() -> some View {
//		Image(self.statusIMG)
//			.resizable()
//			.clipped()
//	}
//
//	func getHorizontalImage() -> some View {
//		Image(self.statusIMG)
//			.resizable()
//			.scaledToFit()
//			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / CGFloat(2))
//			.clipped()
//			.padding(.vertical, 10)
//	}
//
//	func getVerticalVideo() -> some View {
//		VideoView(videoURL: self.urlVideo, previewLength: 60)
//			.frame(width: nil, height: nil, alignment: .center)
//
//	}
//
//	func getHorizontalVideo() -> some View {
//		VideoView(videoURL: self.urlVideo, previewLength: 60)
//			.frame(width: nil, height: UIScreen.screenHeight / 3.5, alignment: .center)
//	}
	
	func getFooterOpenLink(link: URL) -> some View {
		VStack(spacing: 10) {
			Divider()
				.background(Color.white)
			Button(action: {
				UIApplication.shared.open(link)
			}) {
				VStack(spacing: 0) {
					Image(systemName: "chevron.up")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 18, height: 18, alignment: .center)
						.foregroundColor(Color.white)
					Text("Open")
						.foregroundColor(Color.white)
						.font(.system(size: 14, weight: .semibold))
				}
			}
		}
		.padding(.horizontal, 10)
		.padding(.bottom, 25)
	}
	
	var body: some View {
		let tip = self.tips[self.fullScreenIndex.tips]
		let media = tip.medias[self.fullScreenIndex.medias]
		
		return (
			VStack {
				self.progressBar(tip: tip)
				self.backButton(tip: tip)
//				if !isVertical {
//					Spacer()
//					self.getHorizontalVideo()
//				}
				Spacer()
				self.getFooterOpenLink(link: media.url)
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
//			.background(isVertical ? AnyView(self.getVerticalVideo()) : AnyView(Color.black))
			.background(Color.black)
			.edgesIgnoringSafeArea(.all)
		)
	}
}

struct TipsScreenFullScreenImage_Previews: PreviewProvider {
	@State static var tips: [TipsResponse] = [TipsResponse()]
	@State static var fullScreenIndex: (tips: Int, medias: Int) = (tips: 0, medias: 0)
	
	static var previews: some View {
		TipsScreenFullScreenImage(tips: $tips, fullScreenIndex: $fullScreenIndex)
	}
}
