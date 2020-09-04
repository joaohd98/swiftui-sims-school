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
	@Published var teacher: String
	@Published var day: String
	@Published var homework: String
	@Published var weekday: Int
	@Published var test: String
	
	init() {
		course = ""
		teacher = ""
		day = ""
		homework = ""
		weekday = 0
		test = ""
	}
	
	func getDayOfMonth() -> String {
		return String(day.split(separator: "/").first ?? "")
	}
}


extension CalendarCourseResponse {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.course = dictionary["course"] as! String
		self.teacher = dictionary["teacher"] as! String
		self.day = dictionary["day"] as! String
		self.weekday = dictionary["weekday"] as! Int
		self.homework = dictionary["homework"] as! String
		self.test = dictionary["test"] as! String
	}
}
