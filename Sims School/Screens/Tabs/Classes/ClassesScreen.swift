//
//  ClassesScreen.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Foundation

struct ClassesScreen: View {
	
	func getDaysOfWeek() -> some View {
		let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
		
		return (
			HStack {
				ForEach(weekdays.indices) {
					Spacer()
					Text(weekdays[$0])
						.foregroundColor(weekdays[$0] == "S" ? Color(CustomColor.gray) : nil)
						.font(.system(size: 16, weight: .bold))
						.frame(width: 40, height: 40, alignment: .center)
					Spacer()
				}
			}
			.padding(.top, 10)
			.padding(.bottom, 5)
		)
	}
	
	func getCalendar() -> some View {
		let months = [
			"January", "February", "March",
			"April", "May", "June",
			"July", "August", "September",
			"October", "November", "December"
		]
		
		let year = String(Calendar.current.component(.year, from: Date()))

		return (
			ScrollView {
				ForEach(months.indices) { index in
					VStack(spacing: 0) {
						Text("\(months[index]) \(year)")
							.font(.system(size: 18, weight: .semibold))
							.padding(.top, 16)
							.padding(.bottom, 8)
						self.getDaysCalendar(month: String(index + 1), year: year)
					}
				}
			}
		)
	}
	
	func getDaysCalendar(month: String, year: String) -> some View {
		var interval = Date.allDatesFromMonth(month: month, year: year)
		let weekCount = Calendar.current.component(.weekOfMonth, from: interval.last!)
		
		func getDayNumber(weekDay: Int) -> String {
			guard let data = interval.first else { return "" }
		
			if data.getDayOfWeek() == weekDay {
				interval.removeFirst()
				return String(data.getDay())
			}
			
			return ""
		}
		
		return (
			VStack {
				ForEach(0..<weekCount) { _ in
					HStack(alignment: .center) {
						ForEach(1..<8) { weekDay in
							Spacer()
							Text(getDayNumber(weekDay: weekDay))
								.foregroundColor([1, 7].contains(weekDay) ? Color(CustomColor.gray) : nil)
								.font(.system(size: 16, weight: .semibold))
								.padding(.vertical, 10)
								.frame(width: 40, height: 40, alignment: .center)
							Spacer()
						}
					}
				}
			}
		)
	}
	
    var body: some View {
		CustomContainerGuestSignIn {
			VStack(spacing: 0) {
				self.getDaysOfWeek()
				self.getCalendar()
			}
			.navigationBarTitle("Classes", displayMode: .inline)
		}
    }
}

struct ClassesScreen_Previews: PreviewProvider {
    static var previews: some View {
        ClassesScreen()
    }
}
