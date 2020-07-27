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
	@Published var classesStatus: NetworkRequestStatus = .loading
	@Published var classes: [ClassResponse] = []
	@Published var randomAdStatus: NetworkRequestStatus = .loading
	@Published var randomAd: AdsResponse = AdsResponse()
	@Published var currentClass: Int = Calendar.current.component(.weekday, from: Date()) - 1
	
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
					self.classesStatus = .success
					self.classes = classes
				},
				onError: {
					print("error")
				}
			)
		}
	}
	
	func getAdsRequest(ads: FetchedResults<AdsEntity>) {
		AdsService.getAds(
			onSucess: { ads in
				let count = ads.count
				self.randomAd = ads[Int.random(in: 0..<count)]
				self.randomAd.status = .success
			},
			onError: {
				print("error")
			}
		)
	}
}
