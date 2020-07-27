//
//  HomeScreenAds.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import SkeletonUI

struct HomeScreenAds: View {
	@Environment(\.imageCache) var cache: ImageCache
	@State var showSafari = false
	var randomAd: AdsResponse
	@Binding var status: NetworkRequestStatus
	var tryAgain: () -> Void
	
	func getImage(url: URL?) -> some View {
		Button(action: {
			self.showSafari.toggle()
		}) {
			URLImage(url: url, cache: self.cache, configuration: { $0.resizable().renderingMode(.original) })
				.skeleton(with: self.status == .loading)
				.shape(type: .rectangle)
				.frame(height: 175)
				.cornerRadius(10)
				.overlay(
					RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0)
			)
				.padding()
		}
		.disabled(self.status == .loading)
	}
	
	var errorView: some View {
		TryAgainView(
			text: "There was an error when tried to get the ads.",
			onTryAgain: self.tryAgain
		)
			.padding(.horizontal)
	}
	
	var successView: some View {
		self.getImage(url: self.randomAd.image)
			.frame(height: 175)
			.sheet(isPresented: $showSafari) {
				SafariView(url: self.randomAd.url!)
		}
	}
	
	var body: some View {
		Group {
			if status == .failed {
				errorView
					.transition(.opacity)
					.zIndex(0)
			}
			else {
				successView
					.transition(.opacity)
					.zIndex(1)
			}
		}
		.padding(.top, 30)
	}
}

struct HomeScreenAds_Previews: PreviewProvider {
	@State static var adResponse = AdsResponse()
	@State static var status: NetworkRequestStatus = .success
	
	static var previews: some View {
		HomeScreenAds(randomAd: adResponse, status: $status, tryAgain: {})
	}
}
