//
//  SliderOverView.swift
//  Sims School
//
//  Created by João Damazio on 18/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

private protocol CustomView: View {
	func isModalVisible(_ modalVisible: Bool) -> Self
}

struct SliderOverView<Content: View>: CustomView {
	var content: Content
	var height: CGFloat
	@GestureState private var dragState = DragState.inactive
	@State var position = SliderOverViewCardPosition.bottom
	
	init(height: CGFloat, @ViewBuilder content: @escaping () -> Content) {
		self.height = height
		self.content = content()
	}
	
	func isModalVisible(_ modalVisible: Bool) -> SliderOverView<Content> {
		let slide = self
	
		if modalVisible && position == .bottom {
			slide.position = .middle
		}
		
		else if !modalVisible && position != .bottom {
			slide.position = .bottom
		}
		
		return slide
		
	}
	
	var body: some View {
		let drag = DragGesture().updating($dragState) { drag, state, transaction in
			state = .dragging(translation: drag.translation)
		}
		.onEnded(onDragEnded)
		
		return (
			self.content
				.frame(height: self.height)
				.background(Color.white)
				.cornerRadius(10.0)
				.shadow(color: Color(.sRGBLinear, white: 0, opacity: 0.13), radius: 10.0)
				.offset(y: self.position.rawValue + self.dragState.translation.height)
				.animation(.interpolatingSpring(stiffness: 300.0, damping: 30.0, initialVelocity: 10.0))
				.gesture(drag)
		)
	}
	
	private func onDragEnded(drag: DragGesture.Value) {
		let verticalDirection = drag.predictedEndLocation.y - drag.location.y
		let cardTopEdgeLocation = self.position.rawValue + drag.translation.height
		let positionAbove: SliderOverViewCardPosition
		let positionBelow: SliderOverViewCardPosition
		let closestPosition: SliderOverViewCardPosition
		
		if cardTopEdgeLocation <= SliderOverViewCardPosition.middle.rawValue {
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
	}
}

enum SliderOverViewCardPosition: CGFloat {
	case top = 100
	case middle = 400
	case bottom = 850
}

private enum DragState {
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

private struct PreviewView: View {
	var body: some View {
		Text("Hello world")
	}
}

struct SliderOverView_Previews: PreviewProvider {
	@State static var modalVisible: Bool = false
	
	static var previews: some View {
		SliderOverView<PreviewView>(height: 300){
			PreviewView()
		}
	}
}
