//
//  HomeScreenAds.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenAds: View {
    @State var showSafari = false
    @State var urlString = "https://www.amazon.com.br/Last-Us-Part-II-PlayStation/dp/B07DJRFSDF"
	let images: [String] = ["cover-ps4", "cover-xbox-showcase", "cover-iphone"]
	
	func getImage(name: String) -> some View {
		Button(action: {
			self.showSafari.toggle()
		}) {
			Image(name)
				.resizable()
				.renderingMode(.original)
				.frame(height: 175)
				.cornerRadius(10)
				.overlay(
					RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0)
				)
				.padding()
		}
	}
	
    var body: some View {
		self.getImage(name: self.images[0])
			.frame(height: 175)
			.sheet(isPresented: $showSafari) {
				SafariView(url:URL(string: self.urlString)!)
			}
    }
}

struct HomeScreenAds_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenAds()
    }
}
