//
//  HomeScreenPageModel.swift
//  Sims School
//
//  Created by João Damazio on 16/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import SwiftUI

class HomeScreenModel: ObservableObject {
	@Published var classes: [ClassesResponse] = [
		ClassesResponse(text: "ABC"),
		ClassesResponse(text: "DEF"),
		ClassesResponse(text: "GHI"),
		ClassesResponse(text: "JKL"),
		ClassesResponse(text: "MNO")
	]
	@Published var currentClass: Int = 0
	@Published var user: UserEntity? = nil

	func getFetchRequests(users: FetchedResults<UserEntity>) {
		if users.count > 0 {
			self.user = users[0]
		}
	}
}
