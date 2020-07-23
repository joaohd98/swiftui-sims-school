//
//  ClassesScreenCalendar.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ClassesScreenCalendar: View {
	@Binding var modalVisible: Bool
	let year = String(Calendar.current.component(.year, from: Date()))
	let months = [
		"January", "February", "March",
		"April", "May", "June",
		"July", "August", "September",
		"October", "November", "December"
	]
		
	func getCircle(weekDay: Int, day: String) -> AnyView {
		if day != "" {
			if [3].contains(weekDay) {
				return (AnyView(
					Circle()
						.stroke(lineWidth: 1)
						.foregroundColor(Color(CustomColor.success))
						.frame(width: 10, height: 10, alignment: .center)
				))
			}
			
			if ![1, 7].contains(weekDay) {
				return (AnyView(
					Circle()
						.fill(Color(CustomColor.success))
						.frame(width: 10, height: 10, alignment: .center)
				))
			}
		}
		
		return (AnyView(
			EmptyView()
				.frame(width: 10, height: 10, alignment: .center)
		))
	}
	
	func getCalendarContent(interval: inout [Date], weekDay: Int) -> some View {
		var day = ""
		
		if let data = interval.first, data.getDayOfWeek() == weekDay {
			interval.removeFirst()
			day = String(data.getDay())
		}
		
		let colorWeekDay = [1, 7].contains(weekDay) ? Color(CustomColor.gray) : Color(UIColor.init { (trait) -> UIColor in
			return trait.userInterfaceStyle == .dark ? .white : .black
		})
		
		return (
			VStack(spacing: 0) {
				Text(day)
					.foregroundColor(colorWeekDay)
					.font(.system(size: 16, weight: .semibold))
					.padding(.vertical, 10)
					.frame(width: 40, height: 30, alignment: .center)
				self.getCircle(weekDay: weekDay, day: day)
			}
		)
	}
	
	func getDaysCalendar(month: String, year: String) -> some View {
		var interval = Date.allDatesFromMonth(month: month, year: year)
		let weekCount = Calendar.current.component(.weekOfMonth, from: interval.last!)
			
		return (
			VStack {
				ForEach(0..<weekCount) { _ in
					HStack(alignment: .center) {
						ForEach(1..<8) { weekDay in
							Spacer()
							Button(action: {
								self.modalVisible.toggle()
							}) {
								self.getCalendarContent(interval: &interval, weekDay: weekDay)
							}
							.disabled([1, 7].contains(weekDay))
							Spacer()
						}
					}
				}
			}
		)
	}
	
    var body: some View {
		ScrollView {
			ForEach(self.months.indices) { index in
				VStack(spacing: 0) {
					Text("\(self.months[index]) \(self.year)")
						.font(.system(size: 18, weight: .semibold))
						.padding(.top, 16)
						.padding(.bottom, 8)
					self.getDaysCalendar(month: String(index + 1), year: self.year)
				}
			}
			.padding(.bottom, 10)
		}
	}
}

struct ClassesScreenCalendar_Previews: PreviewProvider {
	@State static var modalVisible: Bool = true

    static var previews: some View {
		ClassesScreenCalendar(modalVisible: $modalVisible)
    }
}
