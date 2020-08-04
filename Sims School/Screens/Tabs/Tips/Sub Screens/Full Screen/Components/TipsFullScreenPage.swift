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
		@Binding var isSliding: Bool
		@Binding var isDetectingPress: Bool
		@Binding var nav: SlideHorizontalNav
		
		init(tip: TipsResponse, nav: Binding<SlideHorizontalNav>, presentationMode: Binding<PresentationMode>,
			 isSliding: Binding<Bool>, isDetectingPress: Binding<Bool>, currentSlide: Binding<Int>) {
			
			self.props = TipsFullScreenPageModel(tip: tip)
			self._nav = nav
			self._presentationMode = presentationMode
			self._currentSlide = currentSlide
			self._isDetectingPress = isDetectingPress
			self._isSliding = isSliding
		}
		
		func getOnAppear() -> () -> Void {
			let media = self.props.getActualMedia()
			
			if media.uiImage != nil {
				return self.setTimeImage
			}
				
			else if media.videoView != nil {
				return self.setTimeVideo
			}
				
			else {
				return {}
			}
		}
		
		func setTimeImage() {
			let seconds = 10.0
			let interval = 0.1
			let valueProgress = (1 / seconds) / 10
			
			self.setTime(seconds: seconds, interval: interval, valueProgress: valueProgress)
		}
		
		func setTimeVideo() {
			let seconds = self.props.getActualMedia().videoDuration
			let interval = 0.1
			let valueProgress = (1 / seconds) / 10
			
			self.setTime(seconds: seconds, interval: interval, valueProgress: valueProgress)
			
		}
		
		func setTime(seconds: Double, interval: Double, valueProgress: Double) {
			let media = self.props.getActualMedia()
			media.progress = 0
			self.props.medias[self.props.currentMedia] = media
			
			var seconds = seconds
			
			self.props.timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: true) { timer in
				
				if !self.isDetectingPress && !self.isSliding {
					let media = self.props.getActualMedia()
					
					seconds -= interval
					media.progress += valueProgress
					
					if seconds <= 0 {
						timer.invalidate()
						
						if self.props.currentMedia + 1 >= self.props.medias.count {
							self.nav = .next
							DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
								self.nav = .none
							}
						}
						else {
							self.props.changeStatus(value: 1)
						}
					}
					
					self.props.medias[self.props.currentMedia] = media
				}
			}
		}
		
		func getPropsMedia() -> (media: TipsMediasResponse, changeSlide: Bool, hasPause: Bool,  onAppear: () -> Void) {
			let media = self.props.getActualMedia()
			
			let changeSlide = self.currentSlide != self.props.tip.index
					
			return (
				media: media,
				changeSlide: changeSlide,
				hasPause: self.isSliding || self.isDetectingPress,
				onAppear: self.getOnAppear()
			)
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
			let props = self.getPropsMedia()
			
			return (
				TipsFullScreenImage(
					media: props.media,
					changeSlide: props.changeSlide,
					hasPause: props.hasPause,
					onAppear: props.onAppear
				)
			)
		}
		
		var body: some View {
			let media = self.props.getActualMedia()
			let propsMedia = self.getPropsMedia()
					
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
						TipsFullScreenContainerMedia(
							tip: self.props.tip,
							status: media.status,
							currentMedia: self.$props.currentMedia,
							presentationMode: self.$presentationMode,
							nav: self.$nav,
							isDetectingPress: self.$isDetectingPress,
							onChangeStatus: { value in  self.props.changeStatus(value: value) }) {
								if  media.status == .loading {
									self.loadingView
								}
								else if media.status == .failed {
									self.failedView
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
					.background(TipsFullScreenBackground(
						media: propsMedia.media,
						changeSlide: propsMedia.changeSlide,
						hasPause: propsMedia.hasPause,
						onAppear: propsMedia.onAppear
					))
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
	
