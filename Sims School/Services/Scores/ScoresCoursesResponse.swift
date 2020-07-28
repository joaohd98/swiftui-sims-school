//
//  ScoreCourseResponse.swift
//  Sims School
//
//  Created by João Damazio on 28/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class ScoresCoursesResponse: ObservableObject, Identifiable {
	@Published var av1: Int
	@Published var av2: Int
	@Published var name: String
	@Published var skips: Int

	init() {
		self.av1 = 1
		self.av2 = 1
		self.name = ""
		self.skips = 1
	}
}


extension ScoresCoursesResponse {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.av1 = dictionary["av1"] as! Int
		self.av2 = dictionary["av2"] as! Int
		self.name = dictionary["name"] as! String
		self.skips = dictionary["skips"] as! Int		
	}
}
