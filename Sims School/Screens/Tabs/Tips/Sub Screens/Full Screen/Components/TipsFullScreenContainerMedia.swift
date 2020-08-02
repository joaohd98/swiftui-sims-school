//
//  TipsFullScreenContainerMedia.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenContainerMedia<Content: View>: View {
	@ObservedObject var tip: TipsResponse
	@Binding var currentSlide: Int
	@Binding var isDetectingPress: Bool
	var content: () -> Content

	init(tip: TipsResponse, currentSlide: Binding<Int>, isDetectingPress: Binding<Bool>,
		 @ViewBuilder content: @escaping () -> Content) {
		self.tip = tip
		self._currentSlide = currentSlide
		self._isDetectingPress = isDetectingPress
		self.content = content
	}
	
	func tapHandler(location: CGPoint) {
		let x = location.x
		let half = UIScreen.screenWidth / 2
				
		if x > half {
			if self.tip.mediasIndex - 1 == self.tip.medias.count {
				if let index = self.tip.indicies.nextTip {
					self.currentSlide = index
				}
			}
			else {
				self.tip.mediasIndex += 1
				self.tip.getMedia().getMediaRequest()
			}
		}
		else {
			if self.tip.mediasIndex - 1 == -1 {
				if let index = self.tip.indicies.prevTip {
					self.currentSlide = index
				}
			}
			else {
				self.tip.mediasIndex -= 1
				self.tip.getMedia().getMediaRequest()
			}
		}
	}
	
	func tapContinous(isPressing: Bool) {
		if self.isDetectingPress != isPressing {
			self.isDetectingPress.toggle()
		}
	}
	
	var body: some View {
		Group {
			Background(
				tappedCallback: { location in
					self.tapHandler(location: location)
				},
				tappedContinous:  { hasPress in
					self.tapContinous(isPressing: hasPress)
				})
			.background(self.content())
		}
	}
}

private struct Background: UIViewRepresentable {
	var tappedCallback: (CGPoint) -> Void
	var tappedContinous: (Bool) -> Void

	func makeUIView(context: UIViewRepresentableContext<Background>) -> UIView {
		let v = UIView(frame: .zero)
		let gestureTap = UITapGestureRecognizer(target: context.coordinator,
												action: #selector(Coordinator.tapped))
		
		let gestureKeepPressing = UILongPressGestureRecognizer(target: context.coordinator,
															   action: #selector(Coordinator.handleLongPress))
		
		gestureKeepPressing.minimumPressDuration = 0.2
		gestureKeepPressing.delaysTouchesBegan = true
		
		v.addGestureRecognizer(gestureTap)
		v.addGestureRecognizer(gestureKeepPressing)
		
		return v
	}
	
	class Coordinator: NSObject {
		var tappedCallback: (CGPoint) -> Void
		var tappedContinous: (Bool) -> Void

		init(tappedCallback: @escaping ((CGPoint) -> Void), tappedContinous: @escaping ((Bool) -> Void)) {
			self.tappedCallback = tappedCallback
			self.tappedContinous = tappedContinous
		}
		
		@objc func tapped(gesture: UITapGestureRecognizer) {
			let point = gesture.location(in: gesture.view)
			self.tappedCallback(point)
		}
		
		@objc func handleLongPress(gestureReconizer: UILongPressGestureRecognizer) {
			if gestureReconizer.state != UIGestureRecognizer.State.ended {
				self.tappedContinous(true)
			}
			else {
				self.tappedContinous(false)
			}
		}
	}
	
	func makeCoordinator() -> Background.Coordinator {
		return Coordinator(tappedCallback: self.tappedCallback, tappedContinous: self.tappedContinous)
	}
	
	func updateUIView(_ uiView: UIView,
					  context: UIViewRepresentableContext<Background>) {
	}
	
}

//struct TipsFullScreenContainerMedia_Previews: PreviewProvider {
//    static var previews: some View {
//        TipsFullScreenContainer()
//    }
//}
