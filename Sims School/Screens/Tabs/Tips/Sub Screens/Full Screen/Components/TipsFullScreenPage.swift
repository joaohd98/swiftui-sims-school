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
	@Binding var goPage: Int?
	var isActual: Bool

	@State var isDetectingPress = false
	@ObservedObject var props = TipsFullScreenModelCopy()
	
	init(tip: TipsResponse, isSliding: Binding<Bool>, goPage: Binding<Int?>, isActual: Bool) {
		self.tip = tip
		self._isSliding = isSliding
		self._goPage = goPage
		self.isActual = isActual
		self._isDetectingPress = State(initialValue: false)
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
					tip: self.tip,
					progress: self.props.progress,
					isVisible: !self.isDetectingPress && !self.isSliding
				)
				TipsFullScreenBackButton(
					tip: self.tip,
					isVisible: !self.isDetectingPress && !self.isSliding
				)
				TipsFullScreenContainerMedia(
					tip: self.tip,
					goPage: self.$goPage,
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
