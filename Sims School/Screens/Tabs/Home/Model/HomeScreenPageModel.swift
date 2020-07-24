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
	@Published var user: UserResponse? = nil
	@Published var classes: [ClassResponse] = []
	@Published var currentClass: Int = 0
	
	func getUserRequest(users: FetchedResults<UserEntity>) {
		if users.count > 0 {
			self.user = UserResponse(user: users[0])
		}
	}
	
	func getClassesRequest(storagedClasses: FetchedResults<ClassEntity>) {
		if let id_class = self.user?.id_class {
			ClassService.getClasses(
				request: ClassRequest(id_class: id_class),
				onSucess: { classes in
					self.classes = classes
				},
				onError: {
					print("error")

				}
			)
		}
	}
	
	func getAdsRequest(ads: FetchedResults<AdsEntity>) {
		
	}
}
