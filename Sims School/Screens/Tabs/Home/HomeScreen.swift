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
	@ObservedObject var props: HomeScreenModel = HomeScreenModel()
	
	func viewDidLoad() {
		self.props.getFetchRequests(users: self.users)
	}
	
    var body: some View {
		CustomContainerSignIn {
			ScrollView {
				VStack(alignment: .leading, spacing: 0) {
					HomeScreenProfile(user: self.$props.user)
					HomeScreenClasses(classes: self.$props.classes, currentClass: self.props.currentClass)
					HomeScreenAds()
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
