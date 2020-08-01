//
//  TipsFullScreenPage.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenPage: View {
	var tips: [TipsResponse]
	var tipSelected: TipsResponse
	var tipSelectedIndex: Int
	@Binding var mediaIndex: Int
	@Binding var currentTipIndex: Int
	
	@State var isDetectingPress = false
	@ObservedObject var props = TipsFullScreenModel()
	
	func viewDidLoad() {
//		self.props.initProps(media: self.tipSelected.medias[self.tipSelectedIndex])
	}
	
	func viewDidUnload() {
	}
		
	var failedView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tip.",
			onTryAgain: {
				self.props.status = .loading
				
				let media = self.tipSelected.medias[0]
				
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
					actualIndex: self.mediaIndex,
					statusQuantity: self.tipSelected.medias.count,
					isVisible: !self.isDetectingPress
				)
				TipsFullScreenBackButton(
					tip: self.tipSelected,
					isVisible: !self.isDetectingPress
				)
				TipsFullScreenContainerMedia(
					tips: self.tips,
					tipSelectedIndex: self.tipSelectedIndex,
					mediaIndex: self.$mediaIndex,
					isDetectingPress: self.$isDetectingPress,
					currentTipIndex: self.$currentTipIndex) {
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
						link: self.tipSelected.medias[self.mediaIndex].url,
						isVertical: !self.props.isVerticalIMG && !self.props.isVerticalVideo,
						isVisible: !self.isDetectingPress
					)
				}
			}
			.background(self.props.getBackground())
			.onAppear { self.viewDidLoad() }
			.onDisappear { print("abc")  }
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
