//
//  CustomViewPlayer.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import AVKit

protocol CustomVIew: UIViewRepresentable {
	func hasPause(_ newState: Bool) -> Self;
	func restart(_ newState: Bool) -> Self;
}

struct VideoView: CustomVIew {
	var playerView: PlayerView

	func makeUIView(context: Context) -> PlayerView {
		return playerView
	}

	func updateUIView(_ playerView: PlayerView, context: Context) {

	}
	
	func hasPause(_ newState: Bool) -> VideoView {
		let copy = self
				
		if newState {

			self.playerView.pause()
		}
		else {
			self.playerView.play()
		}

		return copy
	}
	
	
	func restart(_ newState: Bool) -> VideoView {
		let copy = self
				
		if newState {
			self.playerView.stop()
		}
		else {
			self.playerView.play()
		}

		return copy
	}
	
}

//struct CustomUIVideoPlayer_Previews: PreviewProvider {
//	@State static var videoURL = "https://bitdash-a.akamaihd.net/content/sintel/hls/playlist.m3u8"
//
//	static var previews: some View {
//		VideoView(videoURL: URL(string: videoURL)!)
//	}
//}
//
