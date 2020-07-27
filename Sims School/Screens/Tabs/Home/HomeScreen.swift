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
		self.props.getUserRequest(users: self.users)
		self.props.getClassesRequest(storagedClasses: self.classes)
		self.props.getAdsRequest(ads: self.ads)
	}
	
    var body: some View {
		CustomContainerSignIn {
			ScrollView {
				VStack(alignment: .leading, spacing: 0) {
					HomeScreenProfile(user: self.users[0])
					if self.props.classes.count > 0 {
						HomeScreenClasses(classes: self.$props.classes, currentClass: self.$props.currentClass)
					}
					if self.props.randomAd.status != .loading {
						HomeScreenAds(randomAd: self.props.randomAd)
					}
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
