//
//  Service.swift
//  Sims School
//
//  Created by João Damazio on 24/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class ClassService {
	static func getClasses(
		request: ClassRequest,
		onSucess: @escaping (_ user: [ClassResponse]) -> Void,
		onError: @escaping () -> Void
	) {
		let db = FirebaseDatabase.db
		let docUser = db.collection("classes").document(request.id_class)

		docUser.getDocument { (document, error) in
			if let document = document, document.exists, let dictionary = document.data() {
				
				let days = dictionary["days"] as! [[String: Any]]
				let response = days.map { ClassResponse(dictionary: $0) }
				
				onSucess(response)
			}
				
			else {
				onError()
			}
		}
	}
}
