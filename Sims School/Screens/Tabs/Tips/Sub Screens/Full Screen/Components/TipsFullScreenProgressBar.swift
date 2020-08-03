//
//  TipsFullScreenProgressBar.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenProgressBar: View {
	@ObservedObject var tip: TipsResponse
	var currentMedia: Int
	var progress: Double
	var isVisible: Bool
	var size: Double
	
	init(tip: TipsResponse, currentMedia: Int, progress: Double, isVisible: Bool) {
		self.tip = tip
		self.currentMedia = currentMedia
		self.progress = progress
		self.isVisible = isVisible

		self.size = Double(UIScreen.screenWidth) / Double(tip.medias.count) - 10
	}

	func getWidthBar(_ index: Int) -> Double {
		let actualndex = self.currentMedia
				
		if index > actualndex {
			return 0
		}
		if index < actualndex {
			return self.size
		}
		
		return min(Double(self.progress) * self.size, self.size)
	}
	
    var body: some View {
		HStack {
			ForEach(self.tip.medias.indices) { index in
				ZStack(alignment: .leading) {
					Rectangle()
						.frame(width: CGFloat(self.size), height: 6, alignment: .center)
						.opacity(0.3)
						.foregroundColor(Color.gray)
					
					Rectangle()
						.frame(
							width: CGFloat(self.getWidthBar(index)),
							height: 6,
							alignment: .leading
					)
						.foregroundColor(Color.blue)
						.animation(.linear)
				}
				.cornerRadius(45.0)
			}
		}
		.opacity(self.isVisible ? 1 : 0)
		.padding(.vertical, 10)
	}
}

//struct TipsFullScreenProgressBar_Previews: PreviewProvider {
//    static var previews: some View {
//        TipsFullScreenProgressBar()
//    }
//}
