//
//  TipsFullScreenContainerMedia.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenContainerMedia<Content: View>: View {
	var content: () -> Content
	
	init(@ViewBuilder content: @escaping () -> Content) {
		self.content = content
	}
	
    var body: some View {
		Group {
			ZStack {
				Color.black.opacity(0.001)
				Spacer()
			}
			self.content()
			ZStack {
				Color.black.opacity(0.001)
				Spacer()
			}
		}
	}
}

//struct TipsFullScreenContainerMedia_Previews: PreviewProvider {
//    static var previews: some View {
//        TipsFullScreenContainer()
//    }
//}
