//
//  CustomContainer.swift
//  swiftui-escola
//
//  Created by João Damazio on 02/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct CustomContainer<Content: View>: View {
	private var content: Content

	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content()
	}

	var body: some View {
		Color.white
			.frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
			.overlay(content)
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
