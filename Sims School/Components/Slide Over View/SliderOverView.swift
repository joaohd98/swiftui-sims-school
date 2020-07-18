//
//  SliderOverView.swift
//  Sims School
//
//  Created by João Damazio on 18/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct SliderOverView<Content: View>: View {
	var content: Content
    @Binding var isVisible: Bool
	@State var position = CardPosition.middle
    @GestureState private var dragState = DragState.inactive
	
	init(isVisible: Binding<Bool>, @ViewBuilder content: @escaping () -> Content) {
		self._isVisible = isVisible
		self.content = content()
	}
	
	var body: some View {
		let drag = DragGesture().updating($dragState) { drag, state, transaction in
			state = .dragging(translation: drag.translation)
		}
		.onEnded(onDragEnded)
		
		return (
			self.content
				.frame(height: self.isVisible ? UIScreen.main.bounds.height : 0)
				.background(Color.white)
				.cornerRadius(10.0)
				.shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
				.offset(y: self.position.rawValue + self.dragState.translation.height)
				.animation(self.dragState.isDragging ? nil : .interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
				.gesture(drag)
			
		)
	}
	
	private func onDragEnded(drag: DragGesture.Value) {
		let verticalDirection = drag.predictedEndLocation.y - drag.location.y
		let cardTopEdgeLocation = self.position.rawValue + drag.translation.height
		let positionAbove: CardPosition
		let positionBelow: CardPosition
		let closestPosition: CardPosition
		
		if cardTopEdgeLocation <= CardPosition.middle.rawValue {
			positionAbove = .top
			positionBelow = .middle
		} else {
			positionAbove = .middle
			positionBelow = .bottom
		}
		
		if (cardTopEdgeLocation - positionAbove.rawValue) < (positionBelow.rawValue - cardTopEdgeLocation) {
			closestPosition = positionAbove
		} else {
			closestPosition = positionBelow
		}
		
		if verticalDirection > 0 {
			self.position = positionBelow
		} else if verticalDirection < 0 {
			self.position = positionAbove
		} else {
			self.position = closestPosition
		}
		
		if self.position == .bottom {
			self.isVisible.toggle()
			self.position = .middle
		}
	}
}

enum CardPosition: CGFloat {
	case top = 100
	case middle = 500
	case bottom = 850
}

enum DragState {
	case inactive
	case dragging(translation: CGSize)
	
	var translation: CGSize {
		switch self {
		case .inactive:
			return .zero
		case .dragging(let translation):
			return translation
		}
	}
	
	var isDragging: Bool {
		switch self {
		case .inactive:
			return false
		case .dragging:
			return true
		}
	}
}

fileprivate struct PreviewView: View {
	var body: some View {
		Text("Hello world")
	}
}

struct SliderOverView_Previews: PreviewProvider {
	@State static var showModal: Bool = false

	static var previews: some View {
		SliderOverView<PreviewView>(isVisible: $showModal) {
			PreviewView()
		}
	}
}
