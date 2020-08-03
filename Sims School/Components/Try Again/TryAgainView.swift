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
	var color: Color? = nil
	
	var body: some View {
		let borderColor = Color(UIColor { (trait) -> UIColor in
			return trait.userInterfaceStyle == .dark ? .white : .gray
		})
		
		return (
			Group {
				HStack {
					Spacer()
					VStack(alignment: .center, spacing: 10) {
						Image(systemName: "exclamationmark.triangle")
							.resizable()
							.frame(width: 30, height: 30, alignment: .center)
							.foregroundColor(color ?? nil)
						Text(self.text)
							.foregroundColor(color ?? nil)
							.font(.system(size: 13, weight: .medium))
						Text("Check your internet connection and try again!")
							.foregroundColor(color ?? nil)
							.font(.system(size: 13, weight: .medium))
						Button(action: self.onTryAgain) {
							Text("Try Again")
								.foregroundColor(.white)
								.padding(.vertical, 10)
								.padding(.horizontal, 15)
								.background(Color.blue)
								.cornerRadius(5)
						}
						.padding(.vertical)
					}
					Spacer()
				}
				.padding(.all, 10)
				.overlay(
					RoundedRectangle(cornerRadius: 12)
						.stroke(lineWidth: 1)
						.foregroundColor(color ?? borderColor)
				)
			}
			.background((color != nil) ? Color.black : nil)
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
