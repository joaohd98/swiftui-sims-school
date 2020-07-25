//
//  AdsService.swift
//  Sims School
//
//  Created by João Damazio on 25/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class AdsService {
	static func getAds(
		onSucess: @escaping (_ user: [AdsResponse]) -> Void,
		onError: @escaping () -> Void
	) {
		let db = FirebaseDatabase.db
		let doc = db.collection("ads").document("all")

		doc.getDocument { (document, error) in
			if let document = document, document.exists, let dictionary = document.data() {
				
				let group = DispatchGroup()

				let ads = dictionary["ads"] as! [[String: Any]]
				let response = ads.map { AdsResponse(dictionary: $0, group: group) }
				
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
