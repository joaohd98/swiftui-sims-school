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
	@Published var weekday: Int
	@Published var test: String
	
	init() {
		course = ""
		day = ""
		homework = ""
		weekday = 0
		test = ""
	}
}


extension CalendarCourseResponse {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.course = dictionary["course"] as! String
		self.day = dictionary["day"] as! String
		self.weekday = dictionary["weekday"] as! Int
		self.homework = dictionary["homework"] as! String
		self.test = dictionary["test"] as! String
	}
}
