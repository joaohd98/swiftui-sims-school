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
	case TipsScreen
	case MenuScreen
}

struct TabInformation {
	var name: String
	var icon: String
	var screen: AnyView
	var type: TabsRoutes
}

class ViewRouter: ObservableObject {
	@Published var currentView: TabsRoutes = .TipsScreen
	@Published var tabRoutes: [TabsRoutes: TabInformation] = [:]
	
	init() {
		tabRoutes[.HomeScreen] = TabInformation(
			name: "Home", icon: "house.fill", screen: AnyView(HomeScreen()), type: .HomeScreen
		)
		tabRoutes[.ScoresScreen] = TabInformation(
			name: "Scores", icon: "lightbulb.fill", screen: AnyView(ScoresScreen()), type: .ScoresScreen
		)
		
		tabRoutes[.ClassesScreen] = TabInformation(
			name: "Classes", icon: "folder.fill", screen: AnyView(ClassesScreen()), type: .ClassesScreen
		)
		
		tabRoutes[.TipsScreen] = TabInformation(
			name: "Tips", icon: "tray.full.fill", screen: AnyView(TipsScreen()), type: .TipsScreen
		)
		
		tabRoutes[.MenuScreen] = TabInformation(
			name: "Menu", icon: "line.horizontal.3", screen: AnyView(ScoresScreen()), type: .MenuScreen
		)
	}
}
