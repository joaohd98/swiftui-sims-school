//
//  CustomContainerGuest.swift
//  swiftui-escola
//
//  Created by João Damazio on 02/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

fileprivate protocol CustomView: View {
	func isLoading(_ newState: Bool) -> Self;
}

struct CustomContainerGuest<Content: View>: CustomView {
	private var content: Content
	private var isLoading: Bool = false

	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content()
	}
	
	func getBackgroundColor() -> Color {
		return Color(self.isLoading ? CustomColor.bordergray : UIColor.white)
	}
	
	func isLoading(_ newState: Bool) -> CustomContainerGuest<Content> {
		var copy = self
		
		copy.isLoading = newState
	
		return copy
	}
	
	var body: some View {
		NavigationView {
			self.content
				.disabled(self.isLoading)
				.background(self.getBackgroundColor())
				.navigationBarTitle("")
				.navigationBarHidden(true)
		}
	}
	
}

fileprivate struct PreviewView: View {
	var body: some View {
		Text("Hello world")
	}
}

struct CustomContainerGuest_Previews: PreviewProvider {
    static var previews: some View {
		CustomContainerGuest<PreviewView>(content: { PreviewView() })
	 }
}
