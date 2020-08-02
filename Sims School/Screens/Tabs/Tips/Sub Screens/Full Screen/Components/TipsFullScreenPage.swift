//
//  TipsFullScreenPage.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenPage: View {
	@ObservedObject var tip: TipsResponse
	@Binding var isSliding: Bool
	@Binding var currentSlide: Int
	var isActual: Bool
	
	@State var isDetectingPress = false
	
	init(tip: TipsResponse, isSliding: Binding<Bool>, currentSlide: Binding<Int>, isActual: Bool) {
		self.tip = tip
		self._isSliding = isSliding
		self._currentSlide = currentSlide
		self.isActual = isActual
		self._isDetectingPress = State(initialValue: false)
		
		if self.currentSlide == self.tip.index {
			self.tip.getMedia().getMediaRequest()
		}
		
	}
	
	func getBackground() -> AnyView {
		let media = self.tip.getMedia()
		
		if let uiImage = media.uiImage, media.isVerticalIMG {
			return AnyView(getVerticalImage(uiImage))
		}
			
		else if let videoView = media.videoView, media.isVerticalVideo {
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
	
	func getVerticalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight  - 20)
			.clipped()
	}
	
	func getVerticalVideo(_ videoView: VideoView) -> some View {
		videoView
			.frame(width: nil, height: UIScreen.screenHeight - 20, alignment: .center)
	}
	
	var failedView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tip.",
			onTryAgain: {
				self.tip.getMedia().status = .loading
				
				let media = self.tip.getMedia()
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					media.getMediaRequest()
				}
			},
			color: .white
		)
		.padding(.horizontal)
	}
	
	var loadingView: some View {
		ActivityIndicator(color: .black, transform: CGAffineTransform(scaleX: 3, y: 3))
	}
	
	var successView: some View {
		TipsFullScreenImage(media: self.$tip.medias[self.tip.mediasIndex])
	}
	
	var body: some View {
		let media = self.tip.getMedia()
		
		return (
			GeometryReader { geometry in
				VStack {
					TipsFullScreenProgressBar(
						tip: self.tip,
						progress: media.progress,
						isVisible: !self.isDetectingPress && !self.isSliding
					)
					TipsFullScreenBackButton(
						tip: self.tip,
						isVisible: !self.isDetectingPress && !self.isSliding
					)
					TipsFullScreenContainerMedia(
						tip: self.tip,
						currentSlide: self.$currentSlide,
						isDetectingPress: self.$isDetectingPress) {
							if media.status == .failed {
								self.failedView
							}
							else if media.status == .loading {
								self.loadingView
							}
							else {
								self.successView
							}
					}
					if media.status == .success {
						TipsFullScreenOpenLink(
							link: media.url,
							isVertical: !media.isVerticalIMG && !media.isVerticalVideo,
							isVisible: !self.isDetectingPress && !self.isSliding
						)
					}
				}
				.background(self.getBackground())
				.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
				.rotation3DEffect(
					Angle(degrees: Double(geometry.frame(in: .global).minX / 5)),
					axis: (x: 0, y: 10, z: 0)
				)
			}
			.background(Color.black)
		)
	}
}

//struct TipsFullScreenPage_Previews: PreviewProvider {
//	static var previews: some View {
//		TipsFullScreenPage()
//	}
//}
