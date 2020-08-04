//
//  TipsFullScreenBackground.swift
//  Sims School
//
//  Created by João Damazio on 04/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenBackground: View {
	@State var restart: Bool = true
	var media: TipsMediasResponse
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
	
	func getVerticalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight  - 20)
			.clipped()
			.opacity(0.92)
			.onAppear { self.onAppear() }
	}
	
	func getVerticalVideo(_ videoView: VideoView) -> some View {
		videoView
			.restart(restart || changeSlide)
			.hasPause(hasPause)
			.opacity(0.92)
			.opacity(self.opacityVideo())
			.onAppear {
				self.onAppearVideo()
			}
			.onDisappear {
				self.onDisappearVideo()
			}
			.frame(width: nil, height: UIScreen.screenHeight - 20, alignment: .center)
	}
	
    var body: some View {
		Group {
			if media.uiImage != nil && media.isVerticalIMG {
				self.getVerticalImage(media.uiImage!)
				
			}
				
			else if media.videoView != nil && media.isVerticalVideo {
				self.getVerticalVideo(media.videoView!)
			}
				
			else {
				AnyView(Color.black)
			}
		}
		
    }
}

//struct TipsFullScreenBackground_Previews: PreviewProvider {
//    static var previews: some View {
//		TipsFullScreenBackground(
//			restart: TipsMediasResponse(),
//			media: false,
//			changeSlide: false,
//			hasPause: {}
//		)
//    }
//}
