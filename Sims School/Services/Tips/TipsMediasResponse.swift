//
//  TipsMediasResponse.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class TipsMediasResponse: ObservableObject {
	@Published var url: URL!
	@Published var image: String!
	@Published var video: String!
}

extension TipsMediasResponse  {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.url = URL(string: dictionary["url"] as! String)!
		self.image =  dictionary["image"] as? String ?? nil
		self.video =  dictionary["video"] as? String ?? nil
	}
}
