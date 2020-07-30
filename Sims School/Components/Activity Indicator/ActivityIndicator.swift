//
//  ActivityIndicator.swift
//  Sims School
//
//  Created by João Damazio on 05/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: UIViewRepresentable {
	@State var shouldAnimate: Bool = true
	@State var color: UIColor = .white
	@State var transform: CGAffineTransform? = nil
	
	func makeUIView(context: Context) -> UIActivityIndicatorView {
		return UIActivityIndicatorView()
	}

	func updateUIView(_ uiView: UIActivityIndicatorView, context: Context) {
		if self.shouldAnimate {
			uiView.startAnimating()
		} else {
			uiView.stopAnimating()
		}
		
		if let transform = self.transform {
			uiView.transform = transform
		}

		uiView.color = self.color
	}
}

struct ActivityIndicator_Previews: PreviewProvider {
    static var previews: some View {
		ActivityIndicator()
    }
}
