//
//  TipsFullScreenPage.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenPage: View {
	@ObservedObject var props: TipsFullScreenPageModel
	@Binding var presentationMode: PresentationMode
	@Binding var currentSlide: Int
	@Binding var isDetectingPress: Bool
	@Binding var isSliding: Bool
	
	init(tip: TipsResponse, nav: SlideHorizontalNav, presentationMode: Binding<PresentationMode>,
		 isSliding: Binding<Bool>, isDetectingPress: Binding<Bool>, currentSlide: Binding<Int>) {
		
		self.props = TipsFullScreenPageModel(tip: tip, nav: nav)
		
		self._presentationMode = presentationMode
		self._currentSlide = currentSlide
		self._isDetectingPress = isDetectingPress
		self._isSliding = isSliding
	}
	
	func getActualMedia() -> TipsMediasResponse {
		self.props.medias[self.props.currentMedia]
	}
	
	func setTimeImage() {
		var seconds = 10.0
		let interval = 0.1
		let valueProgress = (1 / seconds) / 10
		
		self.props.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
			if !self.isDetectingPress && !self.isSliding {
				let media = self.getActualMedia()
				
				seconds -= interval
				media.progress += valueProgress
				
				if seconds < 0 {
					timer.invalidate()
					
					if self.props.currentMedia + 1 >= self.props.medias.count {
					}
					else {
					}
				}
				
				self.props.medias[self.props.currentMedia] = media
			}
		}
	}
	
	func setTimeVideo() {
		let media = self.getActualMedia()
		
		var seconds = media.videoDuration
		let interval = 0.1
		let valueProgress = (1 / seconds) / 10
		
		self.props.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
			
			if !self.isDetectingPress && !self.isSliding {
				let media = self.getActualMedia()

				seconds -= interval
				media.progress += valueProgress
								
				if seconds <= 0 {
					timer.invalidate()
					
					if self.props.currentMedia + 1 >= self.props.medias.count {

					}
					else {

					}
					
				}
				
				self.props.medias[self.props.currentMedia] = media
			}
		}
	}

	
	func getBackground() -> AnyView {
		let media = self.getActualMedia()
		
		if let uiImage = media.uiImage, media.isVerticalIMG {
			return AnyView(getVerticalImage(uiImage).onAppear { self.setTimeImage() })
				
		}
			
		else if let videoView = media.videoView, media.isVerticalVideo {
			return AnyView(getVerticalVideo(videoView).onAppear { self.setTimeVideo() })

		}
			
		else {
			return AnyView(Color.black)
		}
		
	}
	
	func getVerticalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight  - 20)
			.clipped()
			.opacity(0.92)
	}
	
	func getVerticalVideo(_ videoView: VideoView) -> some View {
		videoView
			.hasPause(self.isDetectingPress || self.isSliding)
			.frame(width: nil, height: UIScreen.screenHeight - 20, alignment: .center)
			.opacity(0.92)
	}
	
	var failedView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tip.",
			onTryAgain: {
				let media = self.props.medias[self.props.currentMedia]
				
				media.status = .loading
				
				self.props.medias[self.props.currentMedia] = media
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.props.mediaRequest()
				}
			},
			color: .white
		)
		.padding(.horizontal)
	}
	
	var loadingView: some View {
		ActivityIndicator(transform: CGAffineTransform(scaleX: 2, y: 2))
	}
	
	var successView: some View {
		let media = self.getActualMedia()
			
		return (
			TipsFullScreenImage(
				media: self.getActualMedia(),
				hasPause: self.isDetectingPress || self.isSliding
			)
			.onAppear { media.image != nil  ? self.setTimeImage() : self.setTimeVideo() }
		)
	}
	
	var body: some View {
		let media = self.getActualMedia()
		

		return (
			GeometryReader { geometry in
				VStack {
					TipsFullScreenProgressBar(
						tip: self.props.tip,
						currentMedia: self.props.currentMedia,
						progress: media.progress,
						isVisible: !self.isDetectingPress
					)
					TipsFullScreenBackButton(
						presentationMode: self.$presentationMode,
						tip: self.props.tip,
						isVisible: !self.isDetectingPress
					)
					if self.currentSlide == self.props.tip.index || media.status == .success {
						TipsFullScreenContainerMedia(
							tip: self.props.tip,
							status: media.status,
							currentMedia: self.$props.currentMedia,
							presentationMode: self.$presentationMode,
							nav: self.$props.nav,
							isDetectingPress: self.$isDetectingPress,
							onChangeStatus: { value in  self.props.changeStatus(value: value) }) {
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
						.onAppear {
							self.props.mediaRequest()
						}
						if media.status == .success {
							TipsFullScreenOpenLink(
								link: media.url,
								isVertical: media.isVerticalIMG && media.isVerticalVideo
							)
						}
					}
					else {
						Group {
							Spacer()
							self.loadingView
							Spacer()
						}
						.onAppear {
							self.props.mediaRequest()
						}
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
