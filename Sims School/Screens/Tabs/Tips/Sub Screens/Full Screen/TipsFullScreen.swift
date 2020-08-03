//
//  TipsFullScreen.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreen: View {
	@Environment(\.presentationMode) var presentationMode
	@ObservedObject var props: TipsFullScreenModel
	@State var index: Int
	@State var isSliding: Bool = false
	@State var isDetectingPress: Bool = false
	@State var nav: SlideHorizontalNav = .none

	init(tips: [TipsResponse], tipIndex: Int) {
		self.props = TipsFullScreenModel(tips: tips, index: tipIndex)
		self._index = State(initialValue: tipIndex)
	}
	
	var body: some View {
		SlideHorizontal(
			self.props.tips.enumerated().map { (index, tip) in
				TipsFullScreenPage(
					tip: self.props.tips[index],
					nav: self.nav,
					presentationMode: self.presentationMode,
					isSliding: self.isSliding,
					isDetectingPress: self.isDetectingPress,
					currentSlide: self.$index
				)
 			},
			hasDots: false,
			currentPage: self.index,
			nav: self.$nav,
			currentPageCallBack: { number in
				self.index = number
			},
			isSlidingCallBack: { isSliding in
				self.isSliding = isSliding
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
