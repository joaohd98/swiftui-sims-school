//
//  PlayerView.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import AVKit

class PlayerView: UIView {
	let playerLayer = AVPlayerLayer()
	
	init(frame: CGRect, url: URL) {
		super.init(frame: frame)
		
		// Create the video player using the URL passed in.
		let player = AVPlayer(url: url)
		player.volume = 0 // Will play audio if you don't set to zero
		player.play() // Set to play once created
		
		// Add the player to our Player Layer
		playerLayer.player = player
		playerLayer.videoGravity = .resizeAspectFill // Resizes content to fill whole video layer.
		playerLayer.backgroundColor = UIColor.black.cgColor
				
		layer.addSublayer(playerLayer)
	}
	
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		playerLayer.frame = bounds
	}
	
}

