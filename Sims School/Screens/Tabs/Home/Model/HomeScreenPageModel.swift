//
//  HomeScreenPageModel.swift
//  Sims School
//
//  Created by João Damazio on 16/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class HomeScreenModel: AllViewModel {
	@Published var classes: [ClassesResponse] = [
		ClassesResponse(text: "ABC"),
		ClassesResponse(text: "DEF"),
		ClassesResponse(text: "GHI"),
		ClassesResponse(text: "JKL"),
		ClassesResponse(text: "MNO")
	]
	@Published var currentClass: Int = 0
}
