//
//  TipsResponse.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class TipsResponse: ObservableObject {
	@Published var name: String
	@Published var medias: [TipsMediasResponse]
	
	init() {
		name = ""
		medias = []
	}
}

extension TipsResponse  {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.name = dictionary["name"] as! String
		let medias = dictionary["medias"] as! [[String: Any]]
		
		medias.forEach { media in
			self.medias.append(TipsMediasResponse(dictionary: media))
		}
	
	}
}
