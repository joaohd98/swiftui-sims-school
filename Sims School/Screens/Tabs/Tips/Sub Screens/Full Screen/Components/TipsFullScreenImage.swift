//
//  TipsFullScreenImage.swift
//  Sims School
//
//  Created by João Damazio on 02/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenImage: View {
	@ObservedObject var media: TipsMediasResponse
	var restart: Bool
	var hasPause: Bool
	var onAppear: () -> Void
	
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
		print("hasPause", hasPause)

		return (
			videoView
				.hasPause(hasPause)
				.restart(restart)
				.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 1.5, alignment: .center)
				.onAppear { self.onAppear() }
		)
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

struct TipsFullScreenImage_Previews: PreviewProvider {
	@State static var media = TipsMediasResponse()
	
	static var previews: some View {
		TipsFullScreenImage(media: media, restart: false, hasPause: false, onAppear: {})
	}
}
