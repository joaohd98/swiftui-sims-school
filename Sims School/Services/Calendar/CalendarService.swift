//
//  CalendarService.swift
//  Sims School
//
//  Created by João Damazio on 29/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class CalendarService {
	static func getCalendar(
		request: CalendarRequest,
		onSucess: @escaping (_ scores: [CalendarResponse]) -> Void,
		onError: @escaping () -> Void
	) {
		let db = FirebaseDatabase.db
		let doc = db.collection("calendar").document(request.id_class)

		doc.getDocument(source: .server) { (document, error) in
			if let document = document, document.exists, let dictionary = document.data() {
				let scores = dictionary["months"] as! [[String: Any]]
				let response = scores.map { CalendarResponse(dictionary: $0) }
				
				onSucess(response)
			}
				
			else {
				onError()
			}
		}
	}
}
