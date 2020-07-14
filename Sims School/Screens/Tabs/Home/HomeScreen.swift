//
//  HomeScreen.swift
//  Sims School
//
//  Created by João Damazio on 13/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
		CustomContainerGuestSignIn {
			VStack(alignment: .leading, spacing: 0) {
				HomeScreenProfile()
				HomeScreenClasses()
				Spacer()
				HomeScreenAds()
			}
			.navigationBarTitle("Meu teste", displayMode: .inline)
		}
	}
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
