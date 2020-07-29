//
//  CalendarCourseResponse.swift
//  Sims School
//
//  Created by João Damazio on 29/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class CalendarCourseResponse: ObservableObject {
	@Published var course: String
	@Published var day: String
	@Published var homework: String
	@Published var test: String
	
	init() {
		course = ""
		day = ""
		homework = ""
		test = ""
	}
}
