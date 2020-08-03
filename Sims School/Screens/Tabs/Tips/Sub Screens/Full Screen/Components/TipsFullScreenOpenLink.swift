//
//  TipsFullScreenOpenLink.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenOpenLink: View {
	var link: URL
	var isVertical: Bool

	var body: some View {
		Button(action: {
			UIApplication.shared.open(self.link)
		}) {
			VStack(spacing: 10) {
				if !isVertical {
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
		.padding(.horizontal, 10)
		.padding(.bottom, 25)
	}
}

//struct TipsFullScreenOpenLink_Previews: PreviewProvider {
//	static var previews: some View {
//		TipsFullScreenOpenLink()
//	}
//}
