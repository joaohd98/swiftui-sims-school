//
//  SlideHorizontalDots.swift
//  Sims School
//
//  Created by João Damazio on 16/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct SlideHorizontalDots: View {
    var numberOfPages: Int
    @Binding var currentPage: Int
	var isLoading: Bool = false
	
	func getPoint(index: Int) -> String {
		return self.currentPage == index ? "circle.fill" : "circle"
	}
	
    var body: some View {
		HStack(alignment: .center, spacing: 15) {
			ForEach(0..<numberOfPages) { index in
				Image(systemName: self.getPoint(index: index))
					.resizable()
					.aspectRatio(contentMode: .fit)
					.foregroundColor(.blue)
					.skeleton(with: self.isLoading)
					.shape(type: .circle)
					.frame(width: 10, height: 10)
			
			}
		}
	}
}

struct SlideHorizontalDots_Previews: PreviewProvider {
	@State static var currentPage: Int = 2
	
    static var previews: some View {
        SlideHorizontalDots(
			numberOfPages: 5,
			currentPage: $currentPage
		)
		.previewLayout(.fixed(width: 300, height: 100))

    }
}
