//
//  ScoreScreenCardScore.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ScoresScreenCardScore: View {
	@State var progressValue: Float = 0.80
	
	func getScoreCircle() -> some View {
		return (
			ZStack {
				Circle()
					.stroke(lineWidth: 5)
					.opacity(0.3)
					.foregroundColor(Color(CustomColor.success))
				
				Circle()
					.trim(from: 0.0, to: CGFloat(min(self.progressValue, 1.0)))
					.stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
					.foregroundColor(Color(CustomColor.success))
					.rotationEffect(Angle(degrees: 270.0))
				
				Text("9.5")
					.bold()
			}
		)
	}
	
	func getScoreBar() -> some View {
		return (
			GeometryReader { geometry in
				ZStack(alignment: .leading) {
					Rectangle()
						.frame(width: geometry.size.width , height: geometry.size.height)
						.opacity(0.3)
						.foregroundColor(Color(CustomColor.success))
					
					Rectangle()
						.frame(
							width: min(
								CGFloat(self.progressValue) * geometry.size.width, geometry.size.width
							),
							height: geometry.size.height
					)
						.foregroundColor(Color(CustomColor.success))
						.animation(.linear)
				}.cornerRadius(45.0)
			}
		)
	}
	
	var body: some View {
		ForEach(0..<5) { _ in
			VStack(spacing: 20) {
				Text("COMUNICAÇÃO E CONTEXTO SOCIAL DA VIDA URBANA")
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 14, weight: .bold))
				Group {
					HStack(alignment: .firstTextBaseline, spacing: 20) {
						VStack(spacing: 10) {
							Text("Média")
							self.getScoreCircle()
								.frame(width: 50, height: 50, alignment: .center)
						}
						VStack(spacing: 10) {
							Text("Faltas")
							self.getScoreCircle()
								.frame(width: 50, height: 50, alignment: .center)
							
						}
						Spacer()
						VStack(spacing: 10) {
							Text("Situação")
							self.getScoreCircle()
								.frame(width: 50, height: 50, alignment: .center)
							
						}
					}
					VStack {
						VStack {
							HStack {
								Text("AV1")
								Spacer()
								Text("9")
							}
							self.getScoreBar()
						}
						VStack {
							HStack {
								Text("AV2")
								Spacer()
								Text("7")
							}
							self.getScoreBar()
						}
					}
				}
				.padding(.horizontal, 20)
			}
			.padding(.all, 15)
			.overlay(
				RoundedRectangle(cornerRadius: 12)
					.stroke(lineWidth: 1)
					.foregroundColor(.white)
					.shadow(color: .gray, radius: 2, x: 0, y: 2)
			)
			.padding(.horizontal, 20)
			.padding(.bottom, 20)
		}
	}
}

struct ScoresScreenCardScore_Previews: PreviewProvider {
	static var previews: some View {
		ScoresScreenCardScore()
	}
}
