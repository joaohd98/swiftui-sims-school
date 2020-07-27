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
	private var firstRun = true
	@Published var user: UserResponse? = nil
	@Published var classesStatus: NetworkRequestStatus = .loading
	@Published var classes: [ClassResponse] = []
	@Published var randomAdStatus: NetworkRequestStatus = .loading
	@Published var randomAd: AdsResponse = AdsResponse()
	@Published var currentClass: Int = Calendar.current.component(.weekday, from: Date()) - 1
	
	func initProps(users: FetchedResults<UserEntity>, classes: FetchedResults<ClassEntity>, ads: FetchedResults<AdsEntity>) {
		if firstRun {
			self.getUserRequest(users: users)
			self.getClassesRequest(classes: classes)
			self.getAdsRequest(ads: ads)
			
			firstRun.toggle()
		}
	}
	
	func getUserRequest(users: FetchedResults<UserEntity>) {
		if users.count > 0 {
			self.user = UserResponse(user: users[0])
		}
	}
	
	func getClassesRequest(classes: FetchedResults<ClassEntity>) {
		if let id_class = self.user?.id_class {
			ClassService.getClasses(
				request: ClassRequest(id_class: id_class),
				onSucess: { classes in
					self.classes = classes
					self.classesStatus = .success
				},
				onError: {
					self.classesStatus = .failed
				}
			)
		}
	}
	
	func getAdsRequest(ads: FetchedResults<AdsEntity>) {		
		AdsService.getAds(
			onSucess: { ads in
				self.randomAd = ads[Int.random(in: 0..<ads.count)]
				self.randomAdStatus = .success
			},
			onError: {
				self.randomAdStatus = .failed
			}
		)
	}
}
