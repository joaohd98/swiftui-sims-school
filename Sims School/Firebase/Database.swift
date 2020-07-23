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

class FirebaseDatabase {
	var db: Firestore!
	
	init() {
		// [START setup]
		let settings = FirestoreSettings()

		Firestore.firestore().settings = settings
		// [END setup]
		db = Firestore.firestore()

	}
	
	func addClass(currentUser: User?) {
		if let user = currentUser {
			
			let collection = db.collection("classes")
			let document = collection.document("weekdays")
			
			document.getDocument { (document, error) in
				if let document = document, document.exists {
					let dataDescription = document.data().map(String.init(describing:)) ?? "nil"
					print("Document data: \(dataDescription)")
				} else {
					print("Document does not exist")
				}
			}
			
			document.setData([
				user.uid: [
					"allDays": [
						[
							"dayName": "Sunday",
							"hasClass": false
						],
						[
							"dayName": "Monday",
							"course": "Software Development",
							"teacher": "Stevie Rogers",
							"place": ""
						],
						[
							"dayName": "Tuesday",
							"course": "Wish Business",
							"teacher": "Nick Furry",
							"place": ""
						],
						[
							"dayName": "Wednesday",
							"course": "Agile development",
							"teacher": "Natasha Romanoff",
							"place": ""
						],
						[
							"dayName": "Thursday",
							"course": "Artificial intelligence and machine learning",
							"teacher": "Tony Stark",
							"place": ""
						],
						[
							"dayName": "Friday",
							"course": "Automation",
							"teacher": "Michelle Jones",
							"place": ""
						],
						[
							"dayName": "Saturday",
							"hasClass": false
						]
					]
				],
			]) { err in
				if let err = err {
					print("Error updating document: \(err)")
				} else {
					print("Document successfully updated")
				}
			}
			
			
			
		}
	}
	
}
