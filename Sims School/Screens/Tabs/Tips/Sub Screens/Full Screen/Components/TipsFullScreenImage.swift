//
//  TipsFullScreenImage.swift
//  Sims School
//
//  Created by João Damazio on 02/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenImage: View {
	@Binding var media: TipsMediasResponse

	func getHorizontalImage(_ uiImage: UIImage) -> some View {
		Image(uiImage: uiImage)
			.resizable()
			.scaledToFit()
			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / 2)
			.clipped()
			.padding(.vertical, 10)
	}
	
	func getHorizontalVideo(_ videoView: VideoView) -> some View {
		videoView
			.frame(width: nil, height: UIScreen.screenHeight / 3.5, alignment: .center)
	}
	
    var body: some View {
		Group {
			if self.media.uiImage != nil && !self.media.isVerticalIMG {
				self.getHorizontalImage(self.media.uiImage!)
			}
			else if self.media.videoView != nil && !self.media.isVerticalVideo {
				self.getHorizontalVideo(self.media.videoView!)
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
		TipsFullScreenImage(media: $media)
    }
}
