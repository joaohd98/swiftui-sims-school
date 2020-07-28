//
//  ScoresResponse.swift
//  Sims School
//
//  Created by João Damazio on 28/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class ScoresResponse: ObservableObject {
	@Published var number: Int
	@Published var courses: [(av1: Int, av2: Int, name: String, skips: Int)]
	
	init() {
		self.number = 0
		self.courses = []
	}
}


extension ScoresResponse {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.number = dictionary["number"] as! Int
		let courses = dictionary["courses"] as! NSArray
		
		
		courses.forEach { course in
			let course = course as! [String: Any]
			
			self.courses.append((
				av1: course["av1"] as! Int,
				av2: course["av2"] as! Int,
				name: course["name"] as! String,
				skips: course["skips"] as! Int
			))
		}
		
		print("courses", self.courses)
		
	}
}

