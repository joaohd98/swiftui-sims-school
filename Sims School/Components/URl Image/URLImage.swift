//
//  URLImage.swift
//  Sims School
//
//  Created by João Damazio on 25/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import SkeletonUI

struct URLImage: View {
	@ObservedObject var loader: ImageLoader
    private let configuration: (Image) -> Image

	init(url: URL?, cache: ImageCache? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
		self.loader = ImageLoader(cache: cache)
		self.configuration = configuration

		if let url = url {
			self.loader.load(url: url)
		}
	}
		
	var image: some View {
        Group {
			configuration((loader.image != nil) ? Image(uiImage: loader.image!) : Image("placeholder"))
				.skeleton(with: loader.image == nil)
				.shape(type: .rectangle)
        }
    }
	
	var body: some View {
		image
			.onDisappear(perform: loader.cancel)
	}
}

struct URLImage_Previews: PreviewProvider {
	static var previews: some View {
		URLImage(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
	}
}
