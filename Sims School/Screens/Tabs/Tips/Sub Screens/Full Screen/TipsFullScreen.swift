//
//  TipsFullScreen.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreen: View {
	@ObservedObject var props: TipsFullScreenModel

	init(tips: [TipsResponse], tipIndex: Int) {
		self.props = TipsFullScreenModel(tips: tips, index: tipIndex)
	}
	
	var body: some View {
		SlideHorizontal(
			self.props.tips.enumerated().map { (index, tip) in
				TipsFullScreenPage(
					tip: self.props.tips[index],
					nav: self.$props.nav,
					isSliding: self.$props.isSliding,
					currentSlide: self.$props.index
				)
			},
			hasDots: false,
			currentPage: self.props.index,
			nav: self.$props.nav,
			currentPageCallBack: { number in
				self.props.index = number
			},
			isSlidingCallBack: { isSliding in

		},
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
