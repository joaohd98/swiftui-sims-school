//
//  ScoreScreenSemesters.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ScoresScreenSemesters: View {
	@State var actualSemester: Int = 2
	
	func getColors(number: Int) -> (Color, Color) {
		let fontColor = self.actualSemester != number ? Color(CustomColor.gray) : Color.white
		let backgroundColor = self.actualSemester != number ? Color(CustomColor.bordergray) : Color.blue
		
		return (fontColor, backgroundColor)
		
	}
	
	func getCircleButton(number: Int) -> some View {
		let (fontColor, backgroundColor) = getColors(number: number)

		return (
			VStack {
				Text("\(number)º")
					.font(.system(size: 12, weight: .bold))
					.foregroundColor(fontColor)
				Text("SEM.")
					.font(.system(size: 12, weight: .bold))
					.foregroundColor(fontColor)
					
			}
			.padding(.all, 10)
			.overlay(Circle().stroke(backgroundColor, lineWidth: 1))
			.background(Circle().fill(backgroundColor))
			.onTapGesture {
				self.actualSemester = number
			}
		)
	}
	
    var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 15) {
				ForEach(1..<9) { number in
					self.getCircleButton(number: number)
				}
			}
			.padding()
		}
    }
}

struct ScoresScreenSemesters_Previews: PreviewProvider {
    static var previews: some View {
        ScoresScreenSemesters()
    }
}
