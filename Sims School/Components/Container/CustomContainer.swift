//
//  CustomContainer.swift
//  swiftui-escola
//
//  Created by João Damazio on 02/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

fileprivate protocol CustomView: View {
	func isLoading(_ newState: Bool) -> Self;
	func hasHeader(_ newState: Bool) -> Self;
}

struct CustomContainer<Content: View>: CustomView {
	private var content: Content
	private var isLoading: Bool = false
	private var hasHeader: Bool = true

	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content()
	}
	
	func getBackgroundColor() -> Color {
		return self.isLoading ? CustomColor.borderInputColor : Color.white
	}
	
	func isLoading(_ newState: Bool) -> CustomContainer<Content> {
		var copy = self
		
		copy.isLoading = newState
	
		return copy
	}

	func hasHeader(_ newState: Bool) -> CustomContainer<Content> {
		var copy = self
			
		copy.hasHeader = newState

		return copy
	}
	
	var body: some View {
		NavigationView {
			self.content
				.disabled(self.isLoading)
				.background(self.getBackgroundColor())
				.navigationBarTitle("")
				.navigationBarHidden(!self.hasHeader)

		}

	}
	
}

fileprivate struct PreviewView: View {
	var body: some View {
		Text("Hello world")
	}
}

struct CustomContainer_Previews: PreviewProvider {
    static var previews: some View {
		CustomContainer<PreviewView>(content: { PreviewView() })
	 }
}
