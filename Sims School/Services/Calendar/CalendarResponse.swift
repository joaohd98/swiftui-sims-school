//
//  CalendarResponse.swift
//  Sims School
//
//  Created by João Damazio on 29/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class CalendarResponse: ObservableObject {
	@Published var name: String
	@Published var weeks: [CalendarWeekResponse]
	 
	init() {
		name = ""
		weeks = []
	}
}

extension CalendarResponse {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.name = dictionary["name"] as! String
		let weeks = dictionary["weeks"] as! NSArray
		
		weeks.forEach { week in
			let week = week as! [String: Any]
			
			self.weeks.append(CalendarWeekResponse(dictionary: week))
		}
	
	}
}
