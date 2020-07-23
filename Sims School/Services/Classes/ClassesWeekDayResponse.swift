//
//  ClassesResponse.swift
//  Sims School
//
//  Created by João Damazio on 16/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ClassesResponse {
	let id = UUID()
    let text: String
}

import Foundation
import FirebaseFirestore

protocol DocumentSerializable {
    init?(dictionary: [String: Any])
}

struct ClassesWeekDayResponse {
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
}


