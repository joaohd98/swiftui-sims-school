//
//  ScoreScreenCardScore.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ScoresScreenCardScore: View {
	var courses: [(av1: Int, av2: Int, name: String, skips: Int)] = []
	@Binding var status: NetworkRequestStatus
	@State var progressValue: Float = 0.80
	
	init(score: ScoresResponse?, status: Binding<NetworkRequestStatus>) {
		self._status = status
		
		if let score = score {
			self.courses = score.courses
		}
	}
	
	
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
	
	func getCard() -> some View {
		let isLoading = status == .loading
		
		return (
			VStack(spacing: 20) {
				Text("COMUNICAÇÃO E CONTEXTO SOCIAL DA VIDA URBANA")
					.skeleton(with: isLoading)
					.frame(height: isLoading ? 32 : nil)
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 14, weight: .bold))
					.padding(.horizontal, 2)
				
				Group {
					HStack(alignment: .firstTextBaseline, spacing: 20) {
						VStack(spacing: 10) {
							Text("Média")
							self.getScoreCircle()
								.skeleton(with: isLoading)
								.frame(width: 55, height: 55, alignment: .center)
						}
						VStack(spacing: 10) {
							Text("Faltas")
							self.getScoreCircle()
								.skeleton(with: isLoading)
								.frame(width: 55, height: 55, alignment: .center)
							
						}
						Spacer()
						VStack(spacing: 10) {
							Text("Situação")
							self.getScoreCircle()
								.skeleton(with: isLoading)
								.frame(width: 55, height: 55, alignment: .center)
							
						}
					}
					
					VStack(spacing: 20) {
						VStack(spacing: 5) {
							HStack {
								Text("AV1")
								Spacer()
								Text("9")
									.skeleton(with: isLoading)
									.shape(type: .rectangle)
									.frame(width: isLoading ? 15 : nil, height: isLoading ? 25 : nil)
							}
							self.getScoreBar()
								.skeleton(with: isLoading)
								.frame(height: isLoading ? 15 : nil)
							
							
						}
						VStack(spacing: 5) {
							HStack {
								Text("AV2")
								Spacer()
								Text("7")
									.skeleton(with: isLoading)
									.shape(type: .rectangle)
									.frame(width: isLoading ? 15 : nil, height: isLoading ? 25 : nil)
							}
							self.getScoreBar()
								.skeleton(with: isLoading)
								.frame(height: isLoading ? 15 : nil)
						}
					}
				}
				.padding(.horizontal, 15)
			}
			.padding(.horizontal, 10)
			.padding(.vertical, 20)
			.overlay(
				RoundedRectangle(cornerRadius: 12)
					.stroke(lineWidth: 1)
					.foregroundColor(.white)
					.shadow(color: .gray, radius: 2, x: 0, y: 2)
				)
				.padding(.all, 15)
		)
	}
	
	var loadingView: some View {
		Group {
			ForEach(0..<3) { _ in
				self.getCard()
			}
		}
	}
	
	var successView: some View {
		Group {
			ForEach(self.courses, id: \.name) { course in
				self.getCard()
			}
		}
	}
	
	var body: some View {
		Group {
			if status == .loading {
				loadingView
			}
			else {
				successView
			}
		}
	}
}

struct ScoresScreenCardScore_Previews: PreviewProvider {
	@State static var score: ScoresResponse = ScoresResponse()
	@State static var status: NetworkRequestStatus = .success
	
	static var previews: some View {
		ScoresScreenCardScore(score: score, status: $status)
	}
}
