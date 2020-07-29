//
//  ScoreScreenSemesters.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ScoresScreenSemesters: View {
	@Binding var scores: [ScoresResponse]
	@Binding var status: NetworkRequestStatus
	@Binding var actualSemester: Int
	
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
			.skeleton(with: status == .loading)
			.shape(type: .circle)
			.disabled(status == .loading)
			.frame(width: 55, height: 55, alignment: .center)
			.onTapGesture {
				self.actualSemester = number
			}
		)
	}
	
	var loadingView: some View {
		ForEach(1..<9) { number in
			self.getCircleButton(number: number)
		}
	}
	
	var successView: some View {
		ForEach(self.scores, id: \.number) { score in
			self.getCircleButton(number: score.number)
		}
	}
	
	var body: some View {
		ScrollView(.horizontal, showsIndicators: false) {
			HStack(spacing: 15) {
				if status == .loading {
					self.loadingView
				}
				else {
					self.successView
				}
			}
			.padding(.horizontal, 30)
		}
		.frame(width: UIScreen.screenWidth)
		.disabled(self.status == .loading)
	}
}

struct ScoresScreenSemesters_Previews: PreviewProvider {
	@State static var scores: [ScoresResponse] = []
	@State static var status: NetworkRequestStatus = .success
	@State static var actualSemester: Int = 0
	
	static var previews: some View {
		ScoresScreenSemesters(scores: $scores, status: $status, actualSemester: $actualSemester)
	}
}
