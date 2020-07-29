//
//  ClassesScreenCalendar.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ClassesScreenCalendar: View {
	@Binding var calendar: [CalendarResponse]
	@Binding var modalVisible: Bool
	
	func getCircle(response: CalendarCourseResponse) -> some View {
		Group {
			if response.course != "" {
				if response.homework != "" || response.test != "" {
					Circle()
						.stroke(lineWidth: 1)
						.foregroundColor(Color(CustomColor.success))
						.frame(width: 10, height: 10, alignment: .center)
				}
					
				else {
					Circle()
						.fill(Color(CustomColor.success))
						.frame(width: 10, height: 10, alignment: .center)
				}
			}
			else {
				EmptyView()
					.frame(width: 10, height: 10, alignment: .center)
			}
		}
	}
	
	func getCalendarContent(response: CalendarCourseResponse) -> some View {
		let colorWeekDay = response.course == "" ? Color(CustomColor.gray) : Color(UIColor { (trait) -> UIColor in
			return trait.userInterfaceStyle == .dark ? .white : .black
		})
		
		let split = response.day.split(separator: "/")
		let day = split.count > 0 ? split[0] : ""
		
		return (
			VStack(spacing: 0) {
				Text(day)
					.foregroundColor(colorWeekDay)
					.font(.system(size: 16, weight: .semibold))
					.padding(.vertical, 10)
					.frame(width: 40, height: 30, alignment: .center)
				self.getCircle(response: response)
			}
		)
	}
	
	func getCourseResponse(days: [CalendarCourseResponse], weekNumber: Int) -> CalendarCourseResponse {
		let day = days.first { (response) -> Bool in
			response.weekday == weekNumber
		}
		
		return day ?? CalendarCourseResponse()
	}
	
	func getDaysCalendar(calendar: CalendarResponse) -> some View {
		VStack {
			ForEach(calendar.weeks, id: \.weekNumber) { week in
				HStack(alignment: .center) {
					ForEach(0..<7) { weekNumber in
						Spacer()
						Button(action: {
							self.modalVisible.toggle()
						}) {
							self.getCalendarContent(response: self.getCourseResponse(days: week.days, weekNumber: weekNumber))
						}
						.disabled(false)
						Spacer()
					}
				}
			}
		}
	}
	
	var body: some View {
		let year = String(Calendar.current.component(.year, from: Date()))
		
		return (
			ScrollView {
				ForEach(self.calendar, id: \.name) { calendar in
					VStack(spacing: 0) {
						Text("\(calendar.name) \(year)")
							.font(.system(size: 18, weight: .semibold))
							.padding(.top, 16)
							.padding(.bottom, 8)
						self.getDaysCalendar(calendar: calendar)
					}
				}
				.padding(.bottom, 10)
			}
		)
	}
}

struct ClassesScreenCalendar_Previews: PreviewProvider {
	@State static var calendar: [CalendarResponse] = []
	@State static var modalVisible: Bool = true
	
	static var previews: some View {
		ClassesScreenCalendar(calendar: $calendar, modalVisible: $modalVisible)
	}
}
