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
	var day: String
	var homework: String
	var test: String
	
	var dictionary: [String: Any] {
		return [
			"course": course,
			"day": day,
			"homework": homework,
			"test": test
		]
	}
}

extension ClassesWeekDayResponse: DocumentSerializable {
	
	init?(dictionary: [String : Any]) {
		guard let course = dictionary["course"] as? String,
			let day = dictionary["day"] as? String,
			let homework = dictionary["homework"] as? String,
			let test = dictionary["test"] as? String
			else { return nil }
		
		self.init(course: course, day: day, homework: homework, test: test)
	}
}

