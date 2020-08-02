//
//  TipsFullScreen.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import AVKit



struct TipsFullScreen: View {
	@Binding var tips: [TipsResponse]
	@Binding var tipIndex: Int
	@State var isSliding: Bool = false
	
	var body: some View {
		SlideHorizontal(
			self.tips.enumerated().map { (index, tip) in
				TipsFullScreenPage(
					tip: self.$tips[index],
					isActual: self.tipIndex == tip.index,
					isSliding: self.$isSliding,
					currentSlide: self.$tipIndex
				)
			},
			hasDots: false,
			currentPage: $tipIndex,
			isSliding: $isSliding,
			isInModal: true
		)
	}
}

//struct TipsScreenFullScreen_Previews: PreviewProvider {
//	@State static var tips: [TipsResponse] = [TipsResponse()]
//	@State static var fullScreenIndex: (tips: Int, medias: Int) = (tips: 0, medias: 0)
//
//	static var previews: some View {
//		TipsFullScreen(tips: tips, fullScreenIndex: $fullScreenIndex)
//	}
//}
