//
//  URLImage.swift
//  Sims School
//
//  Created by João Damazio on 25/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct URLImage: View {
	@ObservedObject var loader: ImageLoader = ImageLoader()
    private let configuration: (Image) -> Image

	init(url: URL?, cache: ImageCache? = nil, configuration: @escaping (Image) -> Image = { $0 }) {
		print("url", url)
		
		if let url = url {
			self.loader = ImageLoader(url: url, cache: cache)
		}
		self.configuration = configuration
	}
		
	var image: some View {
        Group {
            if loader.image != nil {
                configuration(Image(uiImage: loader.image!))
            } else {
				configuration(Image("placeholder"))
            }
        }
    }
	
	var body: some View {
		image
			.onAppear(perform: loader.load)
			.onDisappear(perform: loader.cancel)
	}
}

struct URLImage_Previews: PreviewProvider {
	static var previews: some View {
		URLImage(url: URL(string: "https://image.tmdb.org/t/p/original/pThyQovXQrw2m0s9x82twj48Jq4.jpg")!)
	}
}
