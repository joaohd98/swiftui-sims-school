//
//  MenuScreen.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Firebase
 
struct MenuScreen: View {
	@Binding var currentView: TabsRoutes
	@Binding var currentUser: User?
	@ObservedObject var props = MenuScreenModel()
		
	var body: some View {
		CustomContainerSignIn {
			VStack(alignment: .leading) {
				MenuScreenOptions(options: self.$props.options, currentView: self.$currentView)
				Spacer()
				MenuScreenLogout(currentUser: self.$currentUser)
			}
			.padding()
			.navigationBarTitle("Menu", displayMode: .inline)
			.frame(
				minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .top
			)
		}
	}
}

struct MenuScreen_Previews: PreviewProvider {
	@State static var currentView: TabsRoutes = .MenuScreen
	@State static var currentUser: User? = Auth.auth().currentUser

	static var previews: some View {
		MenuScreen(currentView: self.$currentView, currentUser: self.$currentUser)
	}
}
