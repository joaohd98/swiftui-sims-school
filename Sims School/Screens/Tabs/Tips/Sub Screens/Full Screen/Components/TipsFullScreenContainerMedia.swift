//
//  TipsFullScreenContainerMedia.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenContainerMedia<Content: View>: View {
	var tip: TipsResponse
	var status: NetworkRequestStatus
	@Binding var presentationMode: PresentationMode
	@Binding var currentMedia: Int
	@Binding var nav: SlideHorizontalNav
	@Binding var isDetectingPress: Bool
	var onChangeStatus: (Int) -> Void
	var content: () -> Content
	
	init(tip: TipsResponse, status: NetworkRequestStatus, currentMedia: Binding<Int>,
		 presentationMode: Binding<PresentationMode>, nav: Binding<SlideHorizontalNav>, isDetectingPress: Binding<Bool>,
		 onChangeStatus:  @escaping (Int) -> Void, @ViewBuilder content: @escaping () -> Content) {
		self.tip = tip
		self.status = status
		self._presentationMode = presentationMode
		self._currentMedia = currentMedia
		self._nav = nav
		self._isDetectingPress = isDetectingPress
		self.onChangeStatus = onChangeStatus
		self.content = content
	}
	
	func tapHandler(location: CGPoint) {
		let x = location.x
		let half = UIScreen.screenWidth / 2
		
		if x > half {			
			if self.currentMedia + 1 >= self.tip.medias.count {
				if self.tip.indicies.nextTip != nil {
					self.nav = .next
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
						self.nav = .none
					}
				}
				else {
					self.presentationMode.dismiss()
				}
			}
			else {
				self.onChangeStatus(1)
			}
		}
		else {
			if self.currentMedia - 1 <= -1 {
				if self.tip.indicies.prevTip != nil {
					self.nav = .previous
					DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
						self.nav = .none
					}
				}
				else {
					self.presentationMode.dismiss()
				}
			}
			else {
				self.onChangeStatus(-1)
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
			.background(self.status != .failed ? AnyView(self.content()) : AnyView(EmptyView()))
			.overlay(self.status == .failed ? AnyView(self.content()) : AnyView(EmptyView()))
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
