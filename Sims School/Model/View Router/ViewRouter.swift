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
	case ClassesScreen
	case ChatScreen
	case MenuScreen
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
			name: "Home", icon: "house.fill", screen: AnyView(HomeScreen()), type: .HomeScreen
		)
		tabRoutes[.ScoresScreen] = TabInformation(
			name: "Scores", icon: "lightbulb.fill", screen: AnyView(ScoresScreen()), type: .ScoresScreen
		)
		
		tabRoutes[.ClassesScreen] = TabInformation(
			name: "Classes", icon: "folder.fill", screen: AnyView(ScoresScreen()), type: .ClassesScreen
		)
		
		tabRoutes[.ChatScreen] = TabInformation(
			name: "Chat", icon: "tray.full.fill", screen: AnyView(ScoresScreen()), type: .ChatScreen
		)
		
		tabRoutes[.MenuScreen] = TabInformation(
			name: "Menu", icon: "line.horizontal.3", screen: AnyView(ScoresScreen()), type: .MenuScreen
		)
	}
}
