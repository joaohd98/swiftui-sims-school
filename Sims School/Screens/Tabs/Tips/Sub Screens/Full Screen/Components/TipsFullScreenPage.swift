//
//  TipsFullScreenPage.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenPage: View {
	@Binding var tip: TipsResponse
	var isActual: Bool
	@Binding var isSliding: Bool
	@Binding var currentSlide: Int

	@State var isDetectingPress = false
	@ObservedObject var props = TipsFullScreenModel()
	
	init(tip: Binding<TipsResponse>, isActual: Bool, isSliding: Binding<Bool>, currentSlide: Binding<Int>) {
		self._tip = tip
		self.isActual = isActual
		self._isSliding = isSliding
		self._currentSlide = currentSlide
	}
		
	var failedView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tip.",
			onTryAgain: {
				self.props.status = .loading
				
				let media = self.tip.medias[0]
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.props.getMediaRequest(media: media)
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
		self.props.getImage()
	}
	
	var body: some View {
		GeometryReader { geometry in
			VStack {
				TipsFullScreenProgressBar(
					progress: self.props.progress,
					actualIndex: self.tip.mediasIndex,
					statusQuantity: self.tip.medias.count,
					isVisible: !self.isDetectingPress && !self.isSliding
				)
				TipsFullScreenBackButton(
					tip: self.tip,
					isVisible: !self.isDetectingPress && !self.isSliding
				)
				TipsFullScreenContainerMedia(
					tip: self.$tip,
					currentSlide: self.$currentSlide,
					isDetectingPress: self.$isDetectingPress) {
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
				if self.props.status == .success {
					TipsFullScreenOpenLink(
						link: self.tip.medias[self.tip.mediasIndex].url,
						isVertical: !self.props.isVerticalIMG && !self.props.isVerticalVideo,
						isVisible: !self.isDetectingPress && !self.isSliding
					)
				}
			}
			.background(self.props.getBackground())
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
			.rotation3DEffect(
				Angle(degrees: Double(geometry.frame(in: .global).minX / 5)),
				axis: (x: 0, y: 10, z: 0)
			)
		}
		.background(Color.black)
	}
}

//struct TipsFullScreenPage_Previews: PreviewProvider {
//	static var previews: some View {
//		TipsFullScreenPage()
//	}
//}
