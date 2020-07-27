//
//  TryAgainView.swift
//  Sims School
//
//  Created by João Damazio on 27/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TryAgainView: View {
	var text: String
	var onTryAgain: () ->  Void
	
    var body: some View {
		let borderColor = Color(UIColor { (trait) -> UIColor in
			return trait.userInterfaceStyle == .dark ? .white : .gray
		})
		
		return (
			HStack {
				Spacer()
				VStack(alignment: .center, spacing: 10) {
					Image(systemName: "exclamationmark.triangle")
						.resizable()
						.frame(width: 30, height: 30, alignment: .center)
					Text(self.text)
						.font(.system(size: 13, weight: .medium))
					Text("Check your internet connection and try again!")
						.font(.system(size: 13, weight: .medium))
					Button(action: self.onTryAgain) {
						Text("Try Again")
					}
				}
				Spacer()
			}
			.padding(.all, 10)
			.overlay(
				RoundedRectangle(cornerRadius: 12)
					.stroke(lineWidth: 1)
					.foregroundColor(borderColor)
			)

		)
    }
}

struct TryAgainView_Previews: PreviewProvider {
    static var previews: some View {
        TryAgainView(
			text: "Ocorreu um errro, tentar novamente",
			onTryAgain: {}
		)
    }
}
