//
//  TipsFullScreen.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import AVKit

struct TipsFullScreen: View {
	@Environment(\.presentationMode) var presentationMode
	@Binding var tips: [TipsResponse]
	@Binding var fullScreenIndex: (tips: Int, medias: Int)
    @GestureState var isDetectingPress = false
	@ObservedObject var props = TipsFullScreenModel()

	func viewDidLoad(tip: TipsResponse, media: TipsMediasResponse) {
		self.props.initProps(tip: tip, media: media)
	}

	func tapHandler(value: DragGesture.Value) {
		let x = value.location.x
		let half = UIScreen.screenWidth / 2

		if x > half {
			if self.fullScreenIndex.medias + 1 == self.tips[self.fullScreenIndex.tips].medias.count {
				if self.fullScreenIndex.tips + 1 == self.tips.count {
					self.presentationMode.wrappedValue.dismiss()
				}
				else {
					self.fullScreenIndex = (tips: self.fullScreenIndex.tips + 1, medias: 0)
				}
			}
			else {
				self.fullScreenIndex.medias += 1
			}
		}
		else {
			if self.fullScreenIndex.medias - 1 == -1 {
				if self.fullScreenIndex.tips - 1 == -1 {
					self.presentationMode.wrappedValue.dismiss()
				}
				else {
					self.fullScreenIndex = (tips: self.fullScreenIndex.tips - 1, medias: 0)
				}
			}
			else {
				self.fullScreenIndex.medias -= 1
			}
		}
	}
	
	func longPressHandler() -> GestureStateGesture<SequenceGesture<LongPressGesture, DragGesture>, Bool> {
		LongPressGesture(minimumDuration: 0.2)
		.sequenced(before: DragGesture(minimumDistance: 0, coordinateSpace: .local))
		.updating($isDetectingPress) { value, state, _ in
			switch value {
				  case .second(true, nil):
					  state = true
				  default:
					  break
			}
		}
	}

	var failedView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tip.",
			onTryAgain: {
				self.props.status = .loading
				
				let tip = self.tips[self.fullScreenIndex.tips]
				let media = tip.medias[self.fullScreenIndex.medias]
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.props.getMediaRequest(media: media)
				}
			},
			color: .white
		)
		.padding(.horizontal)
	}
	
	var loadingView: some View {
		ActivityIndicator(transform: CGAffineTransform(scaleX: 3, y: 3))
	}
	
	var successView: some View {
		self.props.getImage()
	}
	
	var body: some View {
		let tip = self.tips[self.fullScreenIndex.tips]
		let media = tip.medias[self.fullScreenIndex.medias]

		return (
			VStack {
				TipsFullScreenProgressBar(
					progress: self.props.progress,
					actualIndex: self.fullScreenIndex.medias,
					statusQuantity: self.tips.count,
					isVisible: !self.isDetectingPress
				)
				TipsFullScreenBackButton(
					tip: tip,
					isVisible: !self.isDetectingPress
				)
				TipsFullScreenContainerMedia {
					if self.props.status == .failed {
						self.failedView
					}
					else if self.props.status == .loading {
						self.loadingView
					}
					else {
						self.successView
					}
				}
//				.gesture(DragGesture(minimumDistance: 0, coordinateSpace: .global).onChanged { value in
//					self.tapHandler(value: value)
//				})
				.gesture(self.longPressHandler())
				if self.props.status == .success {
					TipsFullScreenOpenLink(
						link: media.url,
						isVertical: !self.props.isVerticalIMG && !self.props.isVerticalVideo,
						isVisible: !self.isDetectingPress
					)
				}
			}
			.onAppear { self.viewDidLoad(tip: tip, media:  media) }
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
			.background(self.props.getBackground())
		)
	}
}

//struct TipsScreenFullScreen_Previews: PreviewProvider {
//	@State static var tips: [TipsResponse] = [TipsResponse()]
//	@State static var fullScreenIndex: (tips: Int, medias: Int) = (tips: 0, medias: 0)
//
//	static var previews: some View {
//		TipsFullScreen(tips: tips, fullScreenIndex: $fullScreenIndex)
//	}
//}
