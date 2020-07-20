//
//  ClassesScreenSubjectDay.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ClassesScreenSubjectDay: View {
	let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
	
	
	func daysSelection() -> some View {
		let backgroundColors = Gradient(colors: [
			Color(UIColor.hexStringToUIColor(hex: "#29F4D5")),
			Color(UIColor.hexStringToUIColor(hex: "#B7FF00"))
		])
		
		let gradient = RadialGradient(
			gradient: backgroundColors, center: .top, startRadius: 50, endRadius: 200
		)
		.cornerRadius(5)
		
		return (
			HStack(spacing: 0) {
				ForEach(weekdays.indices) { index in
					Button(action:  {
						
						
					}) {
						VStack(spacing: 30) {
							Text(self.weekdays[index])
								.foregroundColor(self.weekdays[index] == "W" ? Color.black : Color(CustomColor.gray))
							Text(String(index + 1))
								.foregroundColor(self.weekdays[index] == "W" ? Color.black : Color(CustomColor.gray))
						}
					}
					.frame(maxWidth: .infinity)
					.padding(.vertical, 5)
					.background(self.weekdays[index] == "W" ? gradient : nil)
					
				}
			}
			.padding(.top, 10)
			.padding(.bottom, 15)
		)
		
	}
	
	func dayContent() -> some View {
		VStack(spacing: 2) {
			HStack(alignment: .firstTextBaseline, spacing: 20) {
				VStack {
					Image(systemName: "studentdesk")
						.resizable()
						.frame(width: 25, height: 25, alignment: .center)
						.padding(.bottom, -15)
				}
				VStack(alignment: .leading, spacing: 5) {
					Text("Gestão de projeto - Agile")
						.font(.system(size: 16, weight: .semibold))
					Text("Renato silva de lima")
						.font(.system(size: 14, weight: .semibold))
				}
				Spacer()
			}
			HStack(alignment: .firstTextBaseline, spacing: 20) {
				Rectangle()
					.fill(Color.black)
					.frame(width: 2, height: 50)
					.padding(.leading, 10)
				Spacer()
			}
			HStack(alignment: .firstTextBaseline, spacing: 20) {
				VStack {
					Image(systemName: "paperplane")
						.resizable()
						.frame(width: 25, height: 25, alignment: .center)
						.padding(.bottom, -15)
				}
				VStack(alignment: .leading, spacing: 5) {
					Text("Trabalho de agile")
						.font(.system(size: 16, weight: .semibold))
					Text("Grupo de 2 até 4 pessoas")
						.font(.system(size: 14, weight: .semibold))
				}
				Spacer()
			}
			HStack(alignment: .firstTextBaseline, spacing: 20) {
				Rectangle()
					.fill(Color.black)
					.frame(width: 2, height: 50)
					.padding(.leading, 10)
				Spacer()
			}
			HStack(alignment: .firstTextBaseline, spacing: 20) {
				VStack {
					Image(systemName: "paperclip")
						.resizable()
						.frame(width: 25, height: 25, alignment: .center)
						.padding(.bottom, -15)
				}
				VStack(alignment: .leading, spacing: 5) {
					Text("Prova de agile")
						.font(.system(size: 16, weight: .semibold))
					Text("Individual")
						.font(.system(size: 14, weight: .semibold))
				}
				Spacer()
			}
		}
		.padding()
	}
	
	var body: some View {
		ZStack {
			GeometryReader { geometry in
				VStack(spacing: 5) {
					self.daysSelection()
					self.dayContent()
				}
				.padding()
				.frame(width: geometry.size.width, height: geometry.size.height, alignment: .top)
			}
		}
	}
}

struct ClassesScreenSubjectDay_Previews: PreviewProvider {
	
	static var previews: some View {
		ClassesScreenSubjectDay()
	}
}
