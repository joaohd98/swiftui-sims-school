//
//  CustomContainerGuestSignIn.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct CustomContainerGuestSignIn<Content: View>: View {
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

struct CustomContainerGuestSignIn_Previews: PreviewProvider {
    static var previews: some View {
		CustomContainerGuestSignIn<PreviewView>(content: { PreviewView() })
    }
}
