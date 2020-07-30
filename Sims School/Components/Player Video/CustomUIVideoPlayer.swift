//
//  CustomViewPlayer.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import AVKit

struct VideoView: UIViewRepresentable {
	var videoURL: URL
	var previewLength: Double?
	   
	func makeUIView(context: Context) -> PlayerView {
		return PlayerView(frame: .zero, url: videoURL, previewLength: previewLength ?? 15)
	}

	func updateUIView(_ uiView: PlayerView, context: Context) {
	
	}
	
}

struct CustomUIVideoPlayer_Previews: PreviewProvider {
	@State static var videoURL = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
	@State static var previewLength = 10.0
	
	static var previews: some View {
		VideoView(videoURL: URL(string: videoURL)!, previewLength: previewLength)
	}
}

