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
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var props = TipsScreenFullScreenImageModel()
	
	func viewDidLoad(tip: TipsResponse, media: TipsMediasResponse) {
		self.props.initProps(tip: tip, media: media)
	}
	
	func tapHandler(x: CGFloat) {
		let half = UIScreen.screenWidth / 2
		
		if x > half {
			if fullScreenIndex.medias + 1 == tips[fullScreenIndex.tips].medias.count {
				if fullScreenIndex.tips + 1 == tips.count {
					self.presentationMode.wrappedValue.dismiss()
				}
				else {
					fullScreenIndex.tips += 1
				}
			}
			else {
				fullScreenIndex.medias += 1
			}
		}
		else {
			if fullScreenIndex.medias - 1 == -1 {
				if fullScreenIndex.tips - 1 == -1 {
					self.presentationMode.wrappedValue.dismiss()
				}
				else {
					fullScreenIndex.tips -= 1
				}
			}
			else {
				fullScreenIndex.medias -= 1
			}
		}
	}
	
	
	func progressBar(tip: TipsResponse) -> some View {
		let progressValue = CGFloat.random(in: 0 ... 1)
		let statusQuantity = tip.medias.count
		let size = UIScreen.screenWidth / CGFloat(statusQuantity) - 10
		
		let getWidth: (_ index: Int) -> CGFloat = { index in
			let actualndex = self.fullScreenIndex.medias
			
			if index > actualndex {
				return 0
			}
			if index < actualndex {
				return size
			}
			
			return min(CGFloat(progressValue) * size, size)
		}
		
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
								width: getWidth(index),
								height: 6,
								alignment: .leading
						)
							.foregroundColor(Color.blue)
							.animation(.linear)
					}
					.cornerRadius(45.0)
				}
			}
			.opacity(self.props.isLongPressing ? 0 : 1)
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
			.opacity(self.props.isLongPressing ? 0 : 1)
			.padding(.vertical, 10)
			.padding(.horizontal, 20)
			
		}
	}
	
	func getFooterOpenLink(link: URL) -> some View {
		Button(action: {
			UIApplication.shared.open(link)
		}) {
			VStack(spacing: 10) {
				if !self.props.isVerticalIMG && !self.props.isVerticalVideo {
					Divider()
						.frame(height: 2)
						.background(Color.white)
				}
				
				VStack(spacing: 0) {
					Image(systemName: "chevron.up")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 22, height: 22, alignment: .center)
						.foregroundColor(Color.white)
					Text("Open")
						.foregroundColor(Color.white)
						.font(.system(size: 16, weight: .bold))
				}
			}
		}
		.opacity(self.props.isLongPressing ? 0 : 1)
		.padding(.horizontal, 10)
		.padding(.bottom, 25)
	}
	
	var failedView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tip.",
			onTryAgain: {
				self.props.status = .loading
				
				let tip = self.tips[self.fullScreenIndex.tips]
				let media = tip.medias[self.fullScreenIndex.medias]
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.props.getMediaRequest(media: media)
				}
		},
			color: .white
		)
			.padding(.horizontal)
	}
	
	var loadingView: some View {
		ActivityIndicator(transform: CGAffineTransform(scaleX: 3, y: 3))
	}
	
	var successView: some View {
		self.props.getImage()
	}
	
	var body: some View {
		let tip = self.tips[self.fullScreenIndex.tips]
		let media = tip.medias[self.fullScreenIndex.medias]
		
		let tapGesture =  DragGesture(minimumDistance: 0, coordinateSpace: .global)
			.onChanged { value in
				self.tapHandler(x: value.location.x)
			}
		
		return (
			VStack {
				self.progressBar(tip: tip)
				self.backButton(tip: tip)
				Group {
					Spacer()
					if self.props.status == .failed {
						self.failedView
					}
					else if self.props.status == .loading {
						self.loadingView
					}
					else {
						self.successView
					}
					Spacer()
				}
				.contentShape(Rectangle())
				.gesture(tapGesture)
//					.onLongPressGesture(minimumDuration: 1, pressing: { _ in
//						print("isPressing...")
//						if !self.props.isLongPressing {
//							self.props.isLongPressing.toggle()
//						}
//					}) {
//						print("stop...")
//						self.props.isLongPressing.toggle()
//				}
				if self.props.status == .success {
					self.getFooterOpenLink(link: media.url)
				}
			}
			.onAppear { self.viewDidLoad(tip: tip, media: media) }
			.frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top)
			.background(self.props.getBackground())
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
