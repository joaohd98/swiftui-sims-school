//
//  TipsScreenFullScreenImage.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import AVKit

struct TipsScreenFullScreenImage: View {
	@Binding var tips: [TipsResponse]
	@Binding var fullScreenIndex: (tips: Int, medias: Int)
	@State var progress: Int = 0
	@State var status: NetworkRequestStatus = .loading
	@Environment(\.presentationMode) var presentationMode

	func progressBar(tip: TipsResponse) -> some View {
		let progressValue = CGFloat.random(in: 0 ... 0.5)
		let statusQuantity = tip.medias.count
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
	
	func backButton(tip: TipsResponse) -> some View {
		Button(action: {
			self.presentationMode.wrappedValue.dismiss()
		}) {
			HStack(spacing: 10) {
				Image(systemName: "chevron.left")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 20, height: 20, alignment: .center)
					.foregroundColor(Color.white)
				Text(tip.name)
					.foregroundColor(Color.white)
					.font(.system(size: 14, weight: .semibold))
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.padding(.vertical, 10)
			.padding(.horizontal, 20)

		}
	}
	
	func getFooterOpenLink(link: URL) -> some View {
		VStack(spacing: 10) {
			Divider()
				.background(Color.white)
			Button(action: {
				UIApplication.shared.open(link)
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
		.padding(.bottom, 25)
	}
	
	var failedView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tip.",
			onTryAgain: {
				
			},
			color: .white
		)
		.padding(.horizontal)
	}
	
	var loadingView: some View {
		ActivityIndicator(transform: CGAffineTransform(scaleX: 3, y: 3))
	}
	
	var successView: some View {
		Group {
			EmptyView()
		}
	}
	
	var body: some View {
		let tip = self.tips[self.fullScreenIndex.tips]
		let media = tip.medias[self.fullScreenIndex.medias]
		
		return (
			VStack {
				self.progressBar(tip: tip)
				self.backButton(tip: tip)
				if status == .failed {
					Spacer()
					self.failedView
				}
				else if status == .loading {
					Spacer()
					self.loadingView
				}
				else {
					self.successView
				}
				Spacer()
				if status == .success {
					self.getFooterOpenLink(link: media.url)
				}
			}
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
			.background(Color.black)
			.edgesIgnoringSafeArea(.all)
		)
	}
}

struct TipsScreenFullScreenImage_Previews: PreviewProvider {
	@State static var tips: [TipsResponse] = [TipsResponse()]
	@State static var fullScreenIndex: (tips: Int, medias: Int) = (tips: 0, medias: 0)
	
	static var previews: some View {
		TipsScreenFullScreenImage(tips: $tips, fullScreenIndex: $fullScreenIndex)
	}
}
