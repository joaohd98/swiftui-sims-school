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
	@State var mediaIndex: Int = 0
	
	var body: some View {
		SlideHorizontal(
			self.tips.enumerated().map {(index, tip) in
				TipsFullScreenPage(
					tips: tips,
					tipSelected: self.tips[index],
					tipSelectedIndex: tipIndex,
					mediaIndex: $mediaIndex,
					currentTipIndex: self.$tipIndex
				)
			},
			hasDots: false,
			currentPage: $tipIndex,
			isInModal: true
		)
		.background(Color.black)
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
