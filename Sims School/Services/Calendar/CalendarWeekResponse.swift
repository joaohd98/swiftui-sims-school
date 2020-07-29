//
//  CalendarWeekResponse.swift
//  Sims School
//
//  Created by João Damazio on 29/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class CalendarWeekResponse: ObservableObject {
	@Published var weekNumber: Int
	@Published var days: [CalendarCourseResponse]

	init() {
		weekNumber = 0
		days = []
	}
}
