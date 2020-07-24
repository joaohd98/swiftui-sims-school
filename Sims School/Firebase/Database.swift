//
//  AddAllDatabase.swift
//  
//
//  Created by João Damazio on 22/07/20.
//

import Foundation
import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import FirebaseStorage

class FirebaseDatabase {
	var db: Firestore!
	var storage: Storage

	//var idClass = UUID().uuidString
	var idClass = "0CA31E26-3FD2-4FFC-83E7-1736330"
	
	init(currentUser: UserResponse?) {
		// [START setup]
		let settings = FirestoreSettings()
		
		Firestore.firestore().settings = settings
		// [END setup]
		db = Firestore.firestore()
		storage = Storage.storage()

		if let user = currentUser {
			self.addUserInformation(user: user)
			self.addClass()
			self.addCalendar()
			self.addAds()
			self.addScores(user: user)
			self.addTips()

		}
		
	}
	
	func addUserInformation(user: UserResponse) {
		let collection = db.collection("user")
		let document = collection.document(user.uid)
		
		document.setData([ 
			"name": "Hal Jordan",
			"actual_class": "ABC123",
			"course": "Software Enginner",
			"cover_picture": "",
			"profile_picture": "",
			"id_class": self.idClass,
			"rm": "2216105480"
		])
	}
	
	func addClass() {
		let collection = db.collection("classes")
		let document = collection.document(self.idClass)
		
		document.setData([
			"days": [
				[
					"weekDay": "",
					"course": "",
					"teacher": "",
					"place": "",
					"hasClass": false
				],
				[
					"weekDay": "Monday",
					"course": "Software Development",
					"teacher": "Stevie Rogers",
					"place": "Wakanda - Lab 23",
					"hasClass": true
				],
				[
					"weekDay": "Tuesday",
					"course": "Wish Business",
					"teacher": "Nick Furry",
					"place": "Asgard - Lab 11",
					"hasClass": true
				],
				[
					"weekDay": "Wednesday",
					"course": "Agile development",
					"teacher": "Natasha Romanoff",
					"place": "Sokovia - Lab 05",
					"hasClass": true
				],
				[
					"weekDay": "Thursday",
					"course": "Artificial intelligence and machine learning",
					"teacher": "Tony Stark",
					"place": "Hell’s Kitchen - Lab 88",
					"hasClass": true
				],
				[
					"weekDay": "Friday",
					"course": "Automation",
					"teacher": "Michelle Jones",
					"place": "The Quantum Realm - Lab 00",
					"hasClass": true
				],
				[
					"weekDay": "",
					"course": "",
					"teacher": "",
					"place": "",
					"hasClass": false
				]
			]
		])
	}
	
	func getClasses(onComplete:  @escaping (_ weekDays: [ClassesWeekDayResponse]) -> Void) {
		let documentClass = db.collection("classes").document(self.idClass)
		
		documentClass.getDocument { (document, error) in
			if let document = document, document.exists {
				
				let days = document.data()!["days"] as! [[String: Any]]
				let weekDays = days.map { ClassesWeekDayResponse(dictionary: $0)}
				
				onComplete(weekDays)
			}
		}
		
	}
	
	func addCalendar() {
		let documentCalendar = db.collection("calendar").document(self.idClass)
		let year = String(Calendar.current.component(.year, from: Date()))

		var calendar: [[String: Any]] = []

		self.getClasses { (weekDays) in

			for month in 1...12 {
				let days = Date.allDatesFromMonth(month: String(month), year: year)

				days.forEach { (date) in
					let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "dd/MM/yyyy"

					let randomNumber = Int.random(in: 1...4)
					let course = weekDays[date.getDayOfWeek() - 1].course
					
					calendar.append([
						"day": dateFormatter.string(from: date),
						"course": course,
						"homework": course == "" && randomNumber >= 2 ? "Final Homework" : "",
						"test": course == "" && randomNumber >= 3 ? "Final Test" :  ""
					])
				}
			}
		
			documentCalendar.setData(["day": calendar])
			
		}
	}
	
	func addScores(user: UserResponse) {
		let collection = db.collection("score")
		let document = collection.document(user.uid)
		var semesters: [[String: Any]]  = []
		
		self.getClasses { (weekDays) in
			
			for index in 1...8 {
			
				var courses: [[String: Any]] = []
				
				weekDays.forEach { day in
					if day.hasClass {
						courses.append([
							"av1": Int.random(in: 3...10),
							"av2": Int.random(in: 3...10),
							"name": day.course,
							"skips": Int.random(in: 60...100)
						])
					}
				}
				
				semesters.append([
					"number": index,
					"courses": courses
				])
			}
			
			document.setData(["semesters": semesters])

		}
		
	}
	
	func addTips() {
//		let collection = db.collection("tips")
//		let document = collection.document(self.idClass)
		
	}
	
	
	func addAds() {
	
	}
	
}
