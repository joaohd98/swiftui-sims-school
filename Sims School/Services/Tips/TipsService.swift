//
//  TipsService.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class TipsService {
	static func getTips(
		request: TipsRequest,
		onSucess: @escaping (_ tips: [TipsResponse]) -> Void,
		onError: @escaping () -> Void
	) {
		let db = FirebaseDatabase.db
		let doc = db.collection("tips").document(request.id_class)

		doc.getDocument(source: .server) { (document, error) in
			if let document = document, document.exists, let dictionary = document.data() {
				let tips = dictionary["tips"] as! [[String: Any]]
				
				let group = DispatchGroup()

				let response = tips.parallel.map { TipsResponse(dictionary: $0, group: group) }

				group.notify(queue: .main) {
					onSucess(response)
				}
			}
				
			else {
				onError()
			}
		}
	}
}
