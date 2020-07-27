//
//  AdsResponse.swift
//  Sims School
//
//  Created by João Damazio on 25/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class AdsResponse: ObservableObject {
	@Published var image: URL!
	@Published var url: URL!
	
	init() {

	}
}

extension AdsResponse {
	convenience init(dictionary: [String: Any], group: DispatchGroup) {
		self.init()
		self.url = URL(string: dictionary["url"] as! String)

		group.enter()
		let image = dictionary["image"] as! String
		FirebaseDatabase.storage.reference().child(image).downloadURL { url, error in
			if error == nil {
				self.image = url
			}
			
			group.leave()
		}
	}
	
	convenience init(ads: AdsEntity) {
		self.init()
		self.image = ads.image!
		self.url = ads.url!
	}
}
