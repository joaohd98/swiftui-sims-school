//
//  ViewRouter.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//


import Foundation
import SwiftUI
import Combine

enum TabsRoutes {
	case HomeScreen
	case ScoresScreen

}

struct TabInformation {
	var name: String
	var icon: String
	var screen: AnyView
	var type: TabsRoutes
}

class ViewRouter: ObservableObject {
	@Published var currentView: TabsRoutes = .HomeScreen
	@Published var tabRoutes: [TabsRoutes: TabInformation] = [:]
	
	init() {
		tabRoutes[.HomeScreen] = TabInformation(
			name: "Home", icon: "house", screen: AnyView(HomeScreen()), type: .HomeScreen
		)
		tabRoutes[.ScoresScreen] = TabInformation(
			name: "Person", icon: "person", screen: AnyView(ScoresScreen()), type: .ScoresScreen
		)
	}
}
