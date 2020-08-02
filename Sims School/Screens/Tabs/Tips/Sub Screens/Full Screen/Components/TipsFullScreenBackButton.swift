//
//  TipsFullScreenBackButton.swift
//  Sims School
//
//  Created by João Damazio on 31/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsFullScreenBackButton: View {
	@ObservedObject var tip: TipsResponse
	var isVisible: Bool

    var body: some View {
		Button(action: {
		}) {
			HStack(spacing: 10) {
				Image(systemName: "chevron.left")
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 20, height: 20, alignment: .center)
					.foregroundColor(Color.white)
				Text(self.tip.name)
					.foregroundColor(Color.white)
					.font(.system(size: 14, weight: .semibold))
			}
			.frame(maxWidth: .infinity, alignment: .leading)
			.opacity(self.isVisible ? 1 : 0)
			.padding(.vertical, 10)
			.padding(.horizontal, 20)
			
		}
	}
}


//struct TipsFullScreenBackButton_Previews: PreviewProvider {
//    static var previews: some View {
//        TipsFullScreenBackButton()
//    }
//}
