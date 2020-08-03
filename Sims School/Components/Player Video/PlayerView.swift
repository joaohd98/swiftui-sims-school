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
		
		let player = AVPlayer(url: url)
		player.play()
		
		playerLayer.player = player
		playerLayer.videoGravity = .resizeAspect
		playerLayer.backgroundColor = UIColor.black.cgColor
				
		layer.addSublayer(playerLayer)
	}
	
	func pause() {
		playerLayer.player?.pause()
	}
	
	func play() {
		playerLayer.player?.play()
	}
		
	required init?(coder: NSCoder) {
		super.init(coder: coder)
	}
	
	override func layoutSubviews() {
		super.layoutSubviews()
		playerLayer.frame = bounds
	}
	
}

