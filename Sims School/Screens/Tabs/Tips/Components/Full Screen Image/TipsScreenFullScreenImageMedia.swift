//
//  TipsScreenFullScreenImageMedia.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

//import SwiftUI
//
//struct TipsScreenFullScreenImageMedia: View {
//	func isVerticalImage() -> Bool {
//		let imageSource = UIImage(named: self.statusIMG)!
//		let screenHeight = UIScreen.screenHeight
//		
//		let imageWidth = imageSource.size.width * imageSource.scale
//		let imageHeight = imageSource.size.height * imageSource.scale
//		
//		return screenHeight < imageHeight && imageHeight > imageWidth / 2
//	}
//	
//	func isVerticalVideo() -> Bool {
//		
//		let videoTrack = AVAsset(url: self.urlVideo).tracks(withMediaType: AVMediaType.video).first!
//		
//		let transformedVideoSize = videoTrack.naturalSize.applying(videoTrack.preferredTransform)
//		
//		return abs(transformedVideoSize.width) < abs(transformedVideoSize.height)
//	}
//	
//	func getVerticalImage() -> some View {
//		Image(self.statusIMG)
//			.resizable()
//			.clipped()
//	}
//	
//	func getHorizontalImage() -> some View {
//		Image(self.statusIMG)
//			.resizable()
//			.scaledToFit()
//			.frame(width: UIScreen.screenWidth, height: UIScreen.screenHeight / CGFloat(2))
//			.clipped()
//			.padding(.vertical, 10)
//	}
//	
//	func getVerticalVideo() -> some View {
//		VideoView(videoURL: self.urlVideo, previewLength: 60)
//			.frame(width: nil, height: nil, alignment: .center)
//		
//	}
//	
//	func getHorizontalVideo() -> some View {
//		VideoView(videoURL: self.urlVideo, previewLength: 60)
//			.frame(width: nil, height: UIScreen.screenHeight / 3.5, alignment: .center)
//	}
//	
//	var body: some View {
//		Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
//	}
//}
//
//struct TipsScreenFullScreenImageMedia_Previews: PreviewProvider {
//	static var previews: some View {
//		TipsScreenFullScreenImageMedia()
//	}
//}
