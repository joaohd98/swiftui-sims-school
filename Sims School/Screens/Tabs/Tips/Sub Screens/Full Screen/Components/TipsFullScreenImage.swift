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
			.frame(width: nil, height: UIScreen.screenHeight / 2.5, alignment: .center)
	}
	
    var body: some View {
		return (
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
		)
    }
}

//struct TipsFullScreenImage_Previews: PreviewProvider {
//	@State static var tip = TipsResponse()
//	
//    static var previews: some View {
//		TipsFullScreenImage(tip: tip)
//    }
//}
