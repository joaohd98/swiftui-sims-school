//
//  Date.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

extension Date {
	
	static func dateFromString(_ dateString: String, _ dateFormat: String = "dd/MM/yyyy") -> Date {
	   let dateFormatter = DateFormatter()
	   dateFormatter.dateFormat = dateFormat

	   return dateFormatter.date(from: dateString)!
	}
		
	static func allDatesFromMonth(month: String, year: String) -> [Date] {
		var dates : [Date] = []
		var dateFrom =  Date()
		
		var monthComponent = DateComponents()
		monthComponent.month = 1
		monthComponent.day = -1

		let fmt = DateFormatter()
		fmt.dateFormat = "dd/MM/yyy"
		dateFrom = fmt.date(from: "01/\(month)/\(year)")!
		
		let dateTo = Calendar.current.date(byAdding: monthComponent, to: dateFrom)!

		while dateFrom <= dateTo {
			dates.append(dateFromString(fmt.string(from: dateFrom)))
			dateFrom = Calendar.current.date(byAdding: .day, value: 1, to: dateFrom)!
		}

		return dates
	}
	
	static func numberOfWeekInBetweenTwoDates(first: Date, last: Date) -> Int {
		let calendar = Calendar(identifier: .gregorian)
		let weeks = calendar.dateComponents([.weekOfMonth], from: first, to: last)

		return weeks.weekOfMonth! + 1

	}
	
	func getDayOfWeek() -> Int {
		return Calendar.current.dateComponents([.weekday], from: self).weekday!
	}
	
	
	func getDay() -> Int {
		return Calendar.current.dateComponents([.day], from: self).day!
	}
	
}
