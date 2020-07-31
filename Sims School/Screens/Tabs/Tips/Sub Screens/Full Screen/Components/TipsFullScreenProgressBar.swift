//
//  TipsFullScreenProgressBar.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenProgressBar: View {
	var progress: CGFloat
	var actualIndex: Int
	var statusQuantity: Int
	var isVisible: Bool
	var size: CGFloat
	
	init(progress: CGFloat, actualIndex: Int, statusQuantity: Int, isVisible: Bool) {
		self.progress = progress
		self.actualIndex = actualIndex
		self.statusQuantity = statusQuantity
		self.isVisible = isVisible

		self.size = UIScreen.screenWidth / CGFloat(statusQuantity) - 10
	}

	func getWidthBar(_ index: Int) -> CGFloat {
		let actualndex = self.actualIndex
		
		if index > actualndex {
			return 0
		}
		if index < actualndex {
			return self.size
		}
		
		return min(CGFloat(self.progress) * self.size, self.size)
	}
	
    var body: some View {
		HStack {
			ForEach(0..<statusQuantity) { index in
				ZStack(alignment: .leading) {
					Rectangle()
						.frame(width: self.size, height: 6, alignment: .center)
						.opacity(0.3)
						.foregroundColor(Color.gray)
					
					Rectangle()
						.frame(
							width: self.getWidthBar(index),
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
