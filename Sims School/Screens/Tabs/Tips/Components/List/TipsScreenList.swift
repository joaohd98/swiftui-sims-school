//
//  TipsScreenList.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsScreenList: View {
	var statusQuantity = 6
	
	func statusSeparator() -> some View {
		let statusQuantity = Int.random(in: 1 ... 5)

		let size = CGFloat(min(1.0 / CGFloat(statusQuantity), 1.0))
		var trim: [(from: CGFloat, to: CGFloat)] = []

		for i in 1...statusQuantity {
			let isSingular = statusQuantity == 1
			let minusFrom = CGFloat(i - 1) * size + (isSingular ? 0 : 0.025)
			let minusTo = CGFloat(i) * size - (isSingular ? 0 : 0.025)
			
			trim.append((from: minusFrom, to: minusTo))
		}
		
		return (
			ForEach(trim.indices) { index in
				Circle()
					.trim(from: trim[index].from, to: trim[index].to)
					.stroke(style: StrokeStyle(lineWidth: 2, lineCap: .square))
					.foregroundColor(Color.blue)
					.frame(width: 50, height: 50, alignment: .center)
					.padding(.all, 5)
					.rotationEffect(Angle(degrees: 90.0))
			}
		)
	}
	
	func imageQuantityItems() -> some View {
		return (
			ZStack {
				
				Image("cover-ps4")
					.frame(width: 42, height: 42, alignment: .center)
					.cornerRadius(25)
				
				self.statusSeparator()
			
			}
		)
	}
	
	func getItem() -> some View {
		HStack(spacing: 20) {
			self.imageQuantityItems()
				.frame(width: 50, height: 50, alignment: .center)
			VStack(alignment: .leading) {
				Text("Analise e desenvolvimento")
					.lineLimit(2)
					.font(.system(size: 12, weight: .bold))
					.frame(height: 40, alignment: .leading)
				Divider()
			}
			Spacer()
		}
		.padding(.horizontal, 10)
		.padding(.vertical, 5)
	}
	
    var body: some View {
		Group {
			self.getItem()
			self.getItem()
			self.getItem()
			self.getItem()
			self.getItem()
			self.getItem()
			self.getItem()
		}
		.padding(.top, 15)
    }
}

struct TipsScreenList_Previews: PreviewProvider {
    static var previews: some View {
        TipsScreenList()
    }
}
