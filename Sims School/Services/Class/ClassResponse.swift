//
//  Response.swift
//  Sims School
//
//  Created by João Damazio on 24/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class ClassResponse: ObservableObject {
	@Published var course: String
	@Published var weekDay: String
	@Published var hasClass: Bool
	@Published var place: String
	@Published var teacher: String
	
	init() {
		course = ""
		weekDay = ""
		hasClass = true
		teacher = ""
		place = ""
	}
}


extension ClassResponse {
	
	convenience init(dictionary: [String: Any]) {
		self.init()
		self.course = dictionary["course"] as! String
		self.weekDay = dictionary["weekDay"] as! String
		self.hasClass = dictionary["hasClass"] as! Bool
		self.place = dictionary["place"] as! String
		self.teacher = dictionary["teacher"] as! String
	}
	
	convenience init(actualClass: ClassEntity) {
		self.init()
		self.course = actualClass.course!
		self.weekDay = actualClass.weekday!
		self.hasClass = actualClass.hasClass
		self.place = actualClass.place!
		self.teacher = actualClass.teacher!
	}
}
