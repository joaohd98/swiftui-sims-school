//
//  HomeScreen.swift
//  Sims School
//
//  Created by João Damazio on 13/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
	@ObservedObject var props: HomeScreenModel = HomeScreenModel()
	
    var body: some View {
		CustomContainerGuestSignIn {
			ScrollView {
				VStack(alignment: .leading, spacing: 0) {
					HomeScreenProfile()
					HomeScreenClasses(classes: self.$props.classes, currentClass: self.props.currentClass)
					Spacer()
					HomeScreenAds()
				}
				.navigationBarTitle("Meu teste", displayMode: .inline)
			}
		}
	}
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
