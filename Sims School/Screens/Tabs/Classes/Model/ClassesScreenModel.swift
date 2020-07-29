//
//  ClassScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 18/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth

class ClassesScreenModel: ObservableObject {
	let year = String(Calendar.current.component(.year, from: Date()))
	var months: [String: [String]] = [
		"January" : [],
		"February" : [],
		"March" : [],
		"April" : [],
		"May" : [],
		"June" : [],
		"July" : [],
		"August" : [],
		"September" : [],
		"October" : [],
		"November": [],
		"December": []
	]
	
	@Published var isModalVisible: Bool = false
	
	init() {
		
//		var interval = Date.allDatesFromMonth(month: month, year: year)
//		let weekCount = Calendar.current.component(.weekOfMonth, from: interval.last!)
		
	}

}
 
