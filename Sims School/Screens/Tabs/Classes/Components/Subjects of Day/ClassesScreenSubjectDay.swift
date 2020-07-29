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
	@Binding var courseSelected: CalendarCourseResponse
	
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
		var subjects = [
			(icon: "studentdesk", title: courseSelected.course, message: courseSelected.teacher),
		]
		
		if courseSelected.homework != "" {
			subjects.append((icon: "paperplane", title: courseSelected.homework, message: "Grupo de 2 a 4 pessoas"))
		}
		
		if courseSelected.test != "" {
			subjects.append((icon: "paperclip", title: courseSelected.test, message: "Individual"))
		}
		
		return (
			VStack(spacing: 2) {
				ForEach(0..<subjects.count) { index in
					if index > 0 {
						HStack(alignment: .firstTextBaseline, spacing: 20) {
							Rectangle()
								.fill(Color(UIColor { (trait) -> UIColor in return trait.userInterfaceStyle == .dark ? .white : .black}))
								.frame(width: 2, height: 60)
								.padding(.leading, 10)
							Spacer()
						}
					}
					HStack(alignment: .firstTextBaseline, spacing: 20) {
						VStack {
							Image(systemName: subjects[index].icon)
								.resizable()
								.frame(width: 25, height: 25, alignment: .center)
								.padding(.bottom, -15)
						}
						VStack(alignment: .leading, spacing: 5) {
							Text(subjects[index].title)
								.font(.system(size: 16, weight: .semibold))
							Text(subjects[index].message)
								.font(.system(size: 14, weight: .semibold))
						}
						Spacer()
					}
				}
			}
			.padding()
		)
		
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
	@State static var courseSelected: CalendarCourseResponse = CalendarCourseResponse()
	
	static var previews: some View {
		ClassesScreenSubjectDay(courseSelected: $courseSelected)
	}
}
