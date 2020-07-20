//
//  TipsScreenFullScreenImage.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsScreenFullScreenImage: View {
	
	func progressBar() -> some View {
		let progressValue = CGFloat.random(in: 0 ... 0.5)
		let statusQuantity = Int.random(in: 3 ... 10)
		let padding = CGFloat(10)
		let size = UIScreen.screenWidth / CGFloat(statusQuantity) - padding
		
		return (
			HStack {
				ForEach(0..<statusQuantity) { index in
					ZStack(alignment: .leading) {
						Rectangle()
							.frame(width: size, height: 6, alignment: .center)
							.opacity(0.3)
							.foregroundColor(Color.gray)
						
						Rectangle()
							.frame(
								width: min(CGFloat(progressValue) * size, size),
								height: 6,
								alignment: .leading
							)
							.foregroundColor(Color.blue)
							.animation(.linear)
					}
					.cornerRadius(45.0)
				}
			}
			.padding(.vertical, 10)
		)
	}
	
	func backButton() -> some View {
		Button(action: {
			
		}) {
			HStack(spacing: 10) {
				Image(systemName: "chevron.left")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 20, height: 20, alignment: .center)
					.foregroundColor(Color.white)
				Text("Analise e desenvolvimento")
					.foregroundColor(Color.white)
					.font(.system(size: 16, weight: .semibold))
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.vertical, 5)
		}
	}
	
	func getFooterOpenLink() -> some View {
	
		VStack(spacing: 10) {
			Divider()
				.background(Color.white)
			
			Button(action: {
					
			}) {
				VStack(spacing: 0) {
					Image(systemName: "chevron.up")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 18, height: 18, alignment: .center)
						.foregroundColor(Color.white)
					Text("Open")
						.foregroundColor(Color.white)
						.font(.system(size: 14, weight: .semibold))
				}
			}
		}
		.padding(.horizontal, 10)
	}
	
	var body: some View {
		VStack {
			self.progressBar()
			self.backButton()
			Spacer()
			self.getFooterOpenLink()
		}
		.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
		.padding()

	}
}

struct TipsScreenFullScreenImage_Previews: PreviewProvider {
	static var previews: some View {
		TipsScreenFullScreenImage()
	}
}
