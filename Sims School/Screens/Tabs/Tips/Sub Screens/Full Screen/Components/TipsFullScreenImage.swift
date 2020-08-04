//
//  TipsFullScreenImage.swift
//  Sims School
//
//  Created by João Damazio on 02/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI


struct TipsFullScreenImage: View {
	@State var restart: Bool = true
	@ObservedObject var media: TipsMediasResponse
	var changeSlide: Bool
	var hasPause: Bool
	var onAppear: () -> Void
	
	func onAppearVideo() {
		DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
			self.restart = false
			self.onAppear()
		}
	}
	
	func onDisappearVideo() {
		self.restart = true
	}
	
	func opacityVideo() -> Double {
		return self.restart ? 0 : 0.92
	}
	
	func getHorizontalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.scaledToFit()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 1.5)
			.clipped()
			.padding(.vertical, 10)
			.onAppear { self.onAppear() }
	}
	
	func getHorizontalVideo(_ videoView: VideoView) -> some View {
		videoView
			.hasPause(hasPause)
			.restart(restart || changeSlide)
			.frame(
				width: UIScreen.screenWidth,
				height: UIScreen.screenHeight / 1.5,
				alignment: .center
			)
			.opacity(self.opacityVideo())
			.onAppear {
				self.onAppearVideo()
			}
			.onDisappear {
				self.onDisappearVideo()
			}
	}
	
	var body: some View {
		Group {
			if media.uiImage != nil && !media.isVerticalIMG {
				self.getHorizontalImage(media.uiImage!)
			}
			else if media.videoView != nil && !media.isVerticalVideo {
				self.getHorizontalVideo(media.videoView!)
			}
			else {
				EmptyView()
			}
		}
	}
}

//struct TipsFullScreenImage_Previews: PreviewProvider {
//	@State static var media = TipsMediasResponse()
//
//	static var previews: some View {
//		TipsFullScreenImage(media: media, restart: false, isVertical: false, hasPause: false, onAppear: {})
//	}
//}
