//
//  TipsScreenList.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsScreenList: View {
	@Binding var tips: [TipsResponse]
	@Binding var status: NetworkRequestStatus
	@Binding var showFullScreen: Bool
	
	func statusSeparator(statusQuantity: Int) -> some View {
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
				if trim.indices.contains(index) {
					Circle()
						.trim(from: trim[index].from, to: trim[index].to)
						.stroke(style: StrokeStyle(lineWidth: 2, lineCap: .square))
						.foregroundColor(Color.blue)
						.frame(width: 50, height: 50, alignment: .center)
						.padding(.all, 5)
						.rotationEffect(Angle(degrees: 90.0))
				}
			}
		)
	}
	
	func imageQuantityItems(tip: TipsResponse) -> some View {
		let Thumbnail = (tip.thumbnail != nil) ? Image(uiImage: tip.thumbnail) : Image("cover-ps4")
		
		return (
			ZStack {
				Thumbnail
					.resizable()
					.renderingMode(.original)
					.frame(width: 42, height: 42, alignment: .center)
					.cornerRadius(25)
					.skeleton(with: status == .loading)
					.shape(type: .circle)
				if status != .loading {
					self.statusSeparator(statusQuantity: tip.medias.count)
				}
			}
		)
	}
	
	func getItem(tip: TipsResponse) -> some View {
		Button(action: {
			self.showFullScreen = true
		}) {
			HStack(spacing: 20) {
				self.imageQuantityItems(tip: tip)
					.frame(width: 50, height: 50, alignment: .center)
				VStack(alignment: .leading) {
					Group {
						Text(tip.name)
							.skeleton(with: status == .loading)
							.frame(height: status == .loading ? 20 : 40, alignment: .leading)
							.lineLimit(2)
							.font(.system(size: 12, weight: .semibold))
							.foregroundColor(Color(UIColor.init { (trait) -> UIColor in
								return trait.userInterfaceStyle == .dark ? .white : .black
							}))
					}
					.frame(height: 40, alignment: .leading)
					Divider()
				}
				Spacer()
			}
			.padding(.horizontal, 10)
			.padding(.vertical, 5)
		}
	}
	
	var loadingView: some View {
		ForEach(0..<10) { _ in
			self.getItem(tip: TipsResponse())
		}
	}
	
	var successView: some View {
		ForEach(self.tips, id: \.name) { tip in
			self.getItem(tip: tip)
		}
	}
	
	var body: some View {
		ScrollView {
			if status == .loading {
				self.loadingView
					.frame(width: UIScreen.screenWidth)
				
			}
			else {
				self.successView
			}
		}
		.padding(.top, 15)
	}
}

struct TipsScreenList_Previews: PreviewProvider {
	@State static var tips: [TipsResponse] = [TipsResponse()]
	@State static var status: NetworkRequestStatus = .success
	@State static var showFullscreen: Bool = false
	
	static var previews: some View {
		TipsScreenList(tips: $tips, status: $status, showFullScreen: $showFullscreen)
	}
}
