//
//  HomeScreen.swift
//  Sims School
//
//  Created by João Damazio on 13/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
	@FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var users: FetchedResults<UserEntity>
	@FetchRequest(entity: ClassEntity.entity(), sortDescriptors: []) var classes: FetchedResults<ClassEntity>
	@FetchRequest(entity: AdsEntity.entity(), sortDescriptors: []) var ads: FetchedResults<AdsEntity>
	@ObservedObject var props: HomeScreenModel = HomeScreenModel()
	
	func viewDidLoad() {
		self.props.initProps(users: users, classes: classes, ads: ads)
	}
	
	func tryAgainClass() {
		self.props.classesStatus = .loading
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			self.props.getClassesRequest(classes: self.classes)
		})
	}
	
	func tryAgainAds() {
		self.props.randomAdStatus = .loading
		
		DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
			self.props.getAdsRequest(ads: self.ads)
		})
	}
	
	var body: some View {
		CustomContainerSignIn {
			ScrollView(.vertical, showsIndicators: false) {
				VStack(alignment: .leading, spacing: 0) {
					HomeScreenProfile(userEntity: self.users[0])
					HomeScreenClasses(
						classes: self.$props.classes,
						currentClass: self.$props.currentClass,
						status: self.$props.classesStatus,
						tryAgain: self.tryAgainClass
					)
					HomeScreenAds(
						randomAd: self.props.randomAd,
						status: self.$props.randomAdStatus,
						tryAgain: self.tryAgainAds
					)
				}
				.padding(.bottom, 10)
				.navigationBarTitle("Home", displayMode: .inline)
				.onAppear {
					self.viewDidLoad()
				}
			}
		}
	}
}

struct HomeScreen_Previews: PreviewProvider {
	static var previews: some View {
		HomeScreen()
	}
}
