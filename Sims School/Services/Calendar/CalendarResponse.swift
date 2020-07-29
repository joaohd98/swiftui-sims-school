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
