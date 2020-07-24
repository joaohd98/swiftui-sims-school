//
//  Response.swift
//  Sims School
//
//  Created by João Damazio on 24/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

struct ClassResponse {
	var course: String
	var weekDay: String
	var hasClass: Bool
	var place: String
	var teacher: String

	init(dictionary: [String: Any]) {		
		self.course = dictionary["course"] as! String
		self.weekDay = dictionary["weekDay"] as! String
		self.hasClass = dictionary["hasClass"] as! Bool
		self.place = dictionary["place"] as! String
		self.teacher = dictionary["teacher"] as! String
	}
	
	init(actualClass: ClassEntity) {
		self.course = actualClass.course!
		self.weekDay = actualClass.weekday!
		self.hasClass = actualClass.hasClass
		self.place = actualClass.place!
		self.teacher = actualClass.teacher!
	}
}
