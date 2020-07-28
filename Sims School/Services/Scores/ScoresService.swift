//
//  ScoresService.swift
//  Sims School
//
//  Created by João Damazio on 28/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class ScoresService {
	static func getScores(
		request: ScoresRequest,
		onSucess: @escaping (_ scores: [ScoresResponse]) -> Void,
		onError: @escaping () -> Void
	) {
		let db = FirebaseDatabase.db
		let doc = db.collection("score").document(request.id)

		doc.getDocument(source: .server) { (document, error) in
			if let document = document, document.exists, let dictionary = document.data() {
				let scores = dictionary["semesters"] as! [[String: Any]]
				let response = scores.map { ScoresResponse(dictionary: $0) }
				
				onSucess(response)
			}
				
			else {
				onError()
			}
		}
	}
}

