//
//  ScoreScreenCardScore.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

private enum Situation {
	case approved
	case disapproved
	case recovery
}

struct ScoresScreenCardScore: View {
	var courses: [ScoresCoursesResponse] = []
	@Binding var status: NetworkRequestStatus
	@State var progressValue: Float = 0.80
	
	init(score: ScoresResponse?, status: Binding<NetworkRequestStatus>) {
		self._status = status
		
		if let score = score {
			self.courses = score.courses
		}
	}
	
	
	private func getScoreCircle(text: String, percentage: Double, situation: Situation) -> some View {
		let color = Color(situation == .approved ? CustomColor.success : situation == .recovery ? CustomColor.warning : CustomColor.danger)
		
		return (
			ZStack {
				Capsule()
					.stroke(lineWidth: 5)
					.opacity(0.3)
					.foregroundColor(color)
				
				Capsule()
					.trim(from: 0.0, to: CGFloat(min(percentage, 1.0)))
					.stroke(style: StrokeStyle(lineWidth: 5, lineCap: .round, lineJoin: .round))
					.foregroundColor(color)
					.rotationEffect(text.count > 3 ?  Angle(degrees: 0) : Angle(degrees: 270.0))

				
				Text(text)
					.font(.system(size: 14, weight: .semibold))
			}
		)
	}
	
	func getScoreBar(value: Int) -> some View {
		let color = Color(value >= 7 ? CustomColor.success : value >= 4 ? CustomColor.warning : CustomColor.danger)

		return (
			GeometryReader { geometry in
				ZStack(alignment: .leading) {
					Rectangle()
						.frame(width: geometry.size.width , height: geometry.size.height)
						.opacity(0.3)
						.foregroundColor(color)
					
					Rectangle()
						.frame(
							width: min(
								CGFloat(Double(value) / 10) * geometry.size.width, geometry.size.width
							),
							height: geometry.size.height
					)
						.foregroundColor(color)
						.animation(.linear)
				}.cornerRadius(45.0)
			}
		)
	}
	
	func getCard(course: ScoresCoursesResponse) -> some View {
		let isLoading = status == .loading
		
		let scoreAvarege = Double(course.av1 + course.av2) / 2.0
		let scoreAvaregePercentage = scoreAvarege / 10
		let scoreAvaregeSituation: Situation = scoreAvarege >= 7 ? .approved : scoreAvarege >= 4 ? .recovery : .disapproved
		
		
		let skips = "\(course.skips)%"
		let skipsPercentage = Double(course.skips) / 100
		let skipsSituation: Situation = course.skips >= 85 ? .approved : course.skips >= 75 ? .recovery : .disapproved
		
		
		let situation: Situation =  skipsSituation == .recovery || scoreAvaregeSituation == .recovery ? .recovery : skipsSituation == .disapproved || scoreAvaregeSituation == .disapproved ? .disapproved : .approved
		
		let situationText = situation == .recovery ? "Recovery" : situation == .disapproved ? "Disapproved" : "Approved"
		
		return (
			VStack(spacing: 20) {
				Text(course.name)
					.skeleton(with: isLoading)
					.frame(height: isLoading ? 24 : nil)
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 14, weight: .bold))
					.padding(.horizontal, 2)
				
				Group {
					HStack(alignment: .firstTextBaseline, spacing: 20) {
						VStack(spacing: 10) {
							Text("Média")
							self.getScoreCircle(
								text: String(scoreAvarege),
								percentage: scoreAvaregePercentage,
								situation: scoreAvaregeSituation
							)
								.skeleton(with: isLoading)
								.frame(width: 55, height: 55, alignment: .center)
						}
						VStack(spacing: 10) {
							Text("Faltas")
							self.getScoreCircle(
								text: skips,
								percentage: skipsPercentage,
								situation: skipsSituation
							)
								.skeleton(with: isLoading)
								.frame(width: 55, height: 55, alignment: .center)
							
						}
						Spacer()
						VStack(spacing: 10) {
							Text("Situação")
							self.getScoreCircle(
								text: situationText,
								percentage: 1,
								situation: situation
							)
								.skeleton(with: isLoading)
								.frame(width: 100, height: 55, alignment: .center)
							
						}
					}
					
					VStack(spacing: 20) {
						VStack(spacing: 5) {
							HStack {
								Text("AV1")
								Spacer()
								Text(String(course.av1))
									.skeleton(with: isLoading)
									.shape(type: .rectangle)
									.frame(width: isLoading ? 15 : nil, height: isLoading ? 25 : nil)
							}
							self.getScoreBar(value: course.av1)
								.skeleton(with: isLoading)
								.frame(height: isLoading ? 15 : nil)
							
							
						}
						VStack(spacing: 5) {
							HStack {
								Text("AV2")
								Spacer()
								Text(String(course.av2))
									.skeleton(with: isLoading)
									.shape(type: .rectangle)
									.frame(width: isLoading ? 15 : nil, height: isLoading ? 25 : nil)
							}
							self.getScoreBar(value: course.av2)
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
				self.getCard(course: ScoresCoursesResponse())
			}
		}
	}
	
	var successView: some View {
		Group {
			ForEach(self.courses, id: \.name) { course in
				self.getCard(course: course)
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
