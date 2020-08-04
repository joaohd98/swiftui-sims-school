//
//  TipsFullScreenBackground.swift
//  Sims School
//
//  Created by João Damazio on 04/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenBackground: View {
	var media: TipsMediasResponse
	var restart: Bool
	var hasPause: Bool
	var onAppear: () -> Void

	func getVerticalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight  - 20)
			.clipped()
			.opacity(0.92)
			.onAppear { self.onAppear() }
	}
	
	func getVerticalVideo(_ videoView: VideoView) -> some View {
		
		
		return (
			videoView
			.restart(restart)
			.hasPause(hasPause)
			.opacity(0.92)
			.onAppear { self.onAppear() }
			.frame(width: nil, height: UIScreen.screenHeight - 20, alignment: .center)
		)
	
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

struct TipsFullScreenBackground_Previews: PreviewProvider {
    static var previews: some View {
		TipsFullScreenBackground(
			media: TipsMediasResponse(),
			restart: false,
			hasPause: false,
			onAppear: {}
		)
    }
}
