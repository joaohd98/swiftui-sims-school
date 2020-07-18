//
//  CustomContainerSignIn.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct CustomContainerSignIn<Content: View>: View {
	private var content: Content

	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content()
	}
	
    var body: some View {
		NavigationView {
			self.content
		}
    }
}

fileprivate struct PreviewView: View {
	var body: some View {
		Text("Hello world")
	}
}

struct CustomContainerSignIn_Previews: PreviewProvider {
    static var previews: some View {
		CustomContainerSignIn<PreviewView>(content: { PreviewView() })
    }
}
