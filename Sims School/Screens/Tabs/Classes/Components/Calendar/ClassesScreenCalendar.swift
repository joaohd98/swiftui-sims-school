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
	@Binding var dayOfYear: Int
	@Binding var modalVisible: Bool
	@State var firstOffset = true
	
	func getCircle(response: CalendarCourseResponse) -> some View {
		Group {
			if response.course != "" {
				if response.homework != "" || response.test != "" {
					Circle()
						.fill(Color(CustomColor.success))
						.frame(width: 10, height: 10, alignment: .center)
				}
					
				else {
					Circle()
						.stroke(lineWidth: 1)
						.foregroundColor(Color(CustomColor.success))
						.frame(width: 10, height: 10, alignment: .center)
					
				}
			}
			else {
				Circle()
					.opacity(0)
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
	
	func getDaysCalendarContent(days: [CalendarCourseResponse], weekNumber: Int) -> some View {
		let response = days.first { res in res.weekday == weekNumber } ?? CalendarCourseResponse()
		
		return (
			Group {
				Spacer()
				Button(action: {
					self.dayOfYear = Date.dateFromString(response.day).getDayOfYear()
					self.modalVisible.toggle()
				}) {
					self.getCalendarContent(response: response)
				}
				.disabled(response.course == "")
				Spacer()
			}
			
		)
	}
	
	func getDaysCalendar(calendar: CalendarResponse) -> some View {
		VStack {
			ForEach(calendar.weeks, id: \.weekNumber) { week in
				HStack(alignment: .center) {
					ForEach(0..<7) { weekNumber in
						self.getDaysCalendarContent(days: week.days, weekNumber: weekNumber)
					}
				}
			}
		}
	}
	
	var body: some View {
		let year = String(Calendar.current.component(.year, from: Date()))
		let month = Calendar.current.component(.month, from: Date())
		
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
			.introspectScrollView(customize: { scrollView in
				if self.calendar.count > 0 && self.firstOffset {
					var height = 0.0
					
					if month == self.calendar.count - 1 {
						height = Double(scrollView.contentSize.height - scrollView.bounds.size.height + scrollView.contentInset.bottom)
					}
						
					else if month > 0 {
						let realMonth = month - 1
						height = Double(realMonth * 300 - 20 * realMonth)
					}
					
					scrollView.contentOffset = .init(x: 0, y: height)
					
					self.firstOffset.toggle()
				}
			})
		)
	}
}

struct ClassesScreenCalendar_Previews: PreviewProvider {
	@State static var calendar: [CalendarResponse] = []
	@State static var dayOfYear: Int = 0
	@State static var modalVisible: Bool = true
	
	static var previews: some View {
		ClassesScreenCalendar(calendar: $calendar, dayOfYear: $dayOfYear,  modalVisible: $modalVisible)
	}
}
