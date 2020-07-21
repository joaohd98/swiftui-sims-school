//
//  MenuScreenOption.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct MenuScreenOptions: View {
	@Binding var options: [(text: String, image: Image, destination: String)]
	
	func getCard(_ card: (text: String, image: Image, destination: String)) -> some View {
		VStack(alignment: .leading, spacing: 15) {
			card.image
				.resizable()
				.aspectRatio(contentMode: .fit)
				.frame(width: 24, height: 24)
				.foregroundColor(Color.blue)
			Text(card.text)
				.foregroundColor(Color.blue)
		}
		.frame(width: UIScreen.screenWidth / 2 - 60, alignment: .leading)
		.padding()
		.background(Color.white)
		.cornerRadius(15)
		.shadow(color: Color.black.opacity(0.2), radius: 7, x: 0, y: 2)
	}
	
    var body: some View {
		var optionsIndex: [Int] = []
		
		stride(from: 1, to: self.options.count , by: 2).forEach { value in
			optionsIndex.append(value)
		}
		
		return (
			VStack(alignment: .leading) {
				ForEach(optionsIndex.indices) { index in
					HStack {
						self.getCard(self.options[optionsIndex[index] - 1])
						Spacer()
						self.getCard(self.options[optionsIndex[index]])
					}
					.padding(.vertical, UIScreen.screenHeight * 0.02)
				}
			}
		)
        
    }
}

struct MenuScreenOptions_Previews: PreviewProvider {
	@State static var options: [(text: String, image: Image, destination: String)] = []

    static var previews: some View {
		MenuScreenOptions(options: $options)
    }
}
