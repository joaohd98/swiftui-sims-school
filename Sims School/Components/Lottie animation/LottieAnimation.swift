//
//  LottieAnimation.swift
//  Sims School
//
//  Created by João Damazio on 29/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Lottie

struct LottieAnimation: UIViewRepresentable {
	var animationText: String
	
	func makeUIView(context: Context) -> AnimationView {
		let view = AnimationView(name: self.animationText)
		
		view.contentMode = .scaleAspectFit
		view.loopMode = .loop
		view.animationSpeed = 1
		view.play()
		
		return view
	}
	
	func updateUIView(_ uiView: AnimationView, context: Context) {

	}
	
}

struct LottieAnimation_Previews: PreviewProvider {
    static var previews: some View {
        LottieAnimation(animationText: "calendar-animation")
    }
}
