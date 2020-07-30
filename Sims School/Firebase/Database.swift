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
	static var db: Firestore = Firestore.firestore()
	static var storage: Storage = Storage.storage()
	
	//var idClass = UUID().uuidString
	private var idClass = "0CA31E26-3FD2-4FFC-83E7-1736330"
	
	func initFirebaseDataBase(currentUser: User?) {
		if let user = currentUser {
			self.addUserInformation(user: user)
			self.addClass()
			self.addCalendar()
			self.addAds()
			self.addScores(user: user)
			self.addTips()
		}
	}
	
	private func addUserInformation(user: User) {
		let collection = FirebaseDatabase.db.collection("user")
		let document = collection.document(user.uid)
		
		document.setData([
			"name": "Hal Jordan",
			"actual_class": "ABC123",
			"course": "Software Enginner",
			"cover_picture": "cover-picture.jpg",
			"profile_picture": "profile-picture.png",
			"id_class": self.idClass,
			"rm": "2216105480"
		])
	}
	
	private func addClass() {
		let collection = FirebaseDatabase.db.collection("classes")
		let document = collection.document(self.idClass)
		
		document.setData([
			"days": [
				[
					"weekDay": "Sunday",
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
					"course": "Artificial Intelligence and Machine Learning",
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
					"weekDay": "Saturday",
					"course": "",
					"teacher": "",
					"place": "",
					"hasClass": false
				]
			]
		])
	}
	
	private func getClasses(onComplete:  @escaping (_ weekDays: [ClassResponse]) -> Void) {
		let documentClass = FirebaseDatabase.db.collection("classes").document(self.idClass)
		
		documentClass.getDocument { (document, error) in
			if let document = document, document.exists {
				
				let days = document.data()!["days"] as! [[String: Any]]
				let weekDays = days.map { ClassResponse(dictionary: $0)}
				
				onComplete(weekDays)
			}
		}
		
	}
	
	private func addCalendar() {
		let documentCalendar = FirebaseDatabase.db.collection("calendar").document(self.idClass)
		let year = String(Calendar.current.component(.year, from: Date()))
		
		let months = [
			"January", "February", "March",
			"April", "May", "June",
			"July", "August", "September",
			"October", "November", "December"
		]
		
		
		self.getClasses { (weekDays) in
			var calendarResponse: [[String: Any]] = []
			
			months.enumerated().forEach {  (index, month) in
				var response: [String: Any] = [:]
				response["name"] = month
				
				let days = Date.allDatesFromMonth(month: String(index + 1), year: year)
				
				let weeksCount = Calendar.current.component(.weekOfMonth, from: days.last!)
				var weeksResponse: [[String: Any]] = []
				
				for index in 0..<weeksCount {
					weeksResponse.append([
						"weekNumber": index + 1,
						"days": []
					])
				}
				
				days.forEach { (date) in
					let weekActual = Calendar.current.component(.weekOfMonth, from: date) - 1
					let dateFormatter = DateFormatter()
					dateFormatter.dateFormat = "dd/MM/yyyy"
					
					let randomNumber = Int.random(in: 2...4)
					let course = weekDays[date.getDayOfWeek() - 1].course
					let teacher = weekDays[date.getDayOfWeek() - 1].teacher
					
					var weekResponse: [String: Any] = [:]
					
					weekResponse["day"] = dateFormatter.string(from: date)
					weekResponse["course"] = course
					weekResponse["teacher"] = teacher
					weekResponse["weekday"] = date.getDayOfWeek() - 1
					weekResponse["homework"] = course != "" && randomNumber >= 3 ? "Final Homework" : ""
					weekResponse["test"] = course != "" && randomNumber >= 4 ? "Final Test" :  ""
					
					var copy = weeksResponse[weekActual]["days"] as! [[String: Any]]
					copy.append(weekResponse)
					weeksResponse[weekActual]["days"] = copy
				}
				
				response["weeks"] = weeksResponse
				calendarResponse.append(response)
			}
			
			documentCalendar.setData(["months": calendarResponse])
			
		}
	}
	
	private func addScores(user: User) {
		let collection = FirebaseDatabase.db.collection("score")
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
	
	private func addTips() {
		let collection = FirebaseDatabase.db.collection("tips")
		let document = collection.document(self.idClass)
		
		self.getClasses { (weekDays) in
			var elements: [[String: Any]] = []
			
			weekDays.forEach { week in
				if week.course != ""{
					elements.append([
						"name": week.course,
						"medias": []
					])
				}
			}
			
			var tips = FirebaseAssets.tips
			
			while tips.count > 0 {
				let arrayKey = Int(arc4random_uniform(UInt32(tips.count)))
				let randomTip = tips[arrayKey]
				
				let index = Int.random(in: 0..<elements.count)
				
				var existingItems = elements[index]["medias"] as! [[String: Any]]
				existingItems.append(randomTip)
				elements[index]["medias"] = existingItems
	
				tips.remove(at: arrayKey)
			}
			
			document.setData(["tips": elements])
			
		}
	}
	
	
	private func addAds() {
		let collection = FirebaseDatabase.db.collection("ads")
		let document = collection.document("all")
		
		document.setData(["ads": FirebaseAssets.ads])
		
	}
	
}
