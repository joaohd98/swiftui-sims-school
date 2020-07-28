//
//  TabsScreen.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct TabsScreen: View {
	@ObservedObject var viewRouter = ViewRouter()
	@ObservedObject var propsHome = HomeScreenModel()
	@ObservedObject var propsScore = ScoreScreenModel()

	init() {
		self.viewRouter.tabRoutes.append(
			TabInformation(
				name: "Home",
				icon: "house.fill",
				screen: AnyView(HomeScreen(props: self.propsHome)),
				type: .HomeScreen
			)
		)
		
		self.viewRouter.tabRoutes.append(
			TabInformation(
				name: "Scores",
				icon: "lightbulb.fill",
				screen: AnyView(ScoresScreen(props: self.propsScore)),
				type: .ScoresScreen
			)
		)
		
		self.viewRouter.tabRoutes.append(
			TabInformation(
				name: "Classes",
				icon: "folder.fill",
				screen: AnyView(ClassesScreen()),
				type: .ClassesScreen
			)
		)
		
		self.viewRouter.tabRoutes.append(
			TabInformation(
				name: "Tips",
				icon: "tray.full.fill",
				screen: AnyView(TipsScreen()),
				type: .TipsScreen
			)
		)
		
		self.viewRouter.tabRoutes.append(
			TabInformation(
				name: "Menu", icon: "line.horizontal.3",
				screen: AnyView(MenuScreen(
					currentView: self.$viewRouter.currentView
				)),
				type: .MenuScreen
			)
		)
	}
	
	func getTabIcon(_ geometry: GeometryProxy, tab: TabInformation) -> some View {
		let currentView = self.viewRouter.currentView
		let countTab = CGFloat(self.viewRouter.tabRoutes.count)
		let widthTab = geometry.size.width / countTab
		
		return (
			Button(action: {
				withAnimation {
					self.viewRouter.currentView = tab.type
				}
			}) {
				VStack(spacing: 0) {
					Divider()
						.frame(height: 2)
						.background(currentView == tab.type ? Color.blue : nil)
					
					Spacer()
					
					Image(systemName: tab.icon)
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 20, height: 20)
						.foregroundColor(currentView == tab.type ? .blue : .gray)
						.padding(.bottom, 2)
					
					Text(tab.name)
						.foregroundColor(currentView == tab.type ? .blue : .gray)
						.font(.system(size: 10, weight: .medium, design: .default))
						.padding(.top, 2)
					
					Spacer()
				}
			}
			.frame(width: widthTab, height: geometry.size.height / 10, alignment: .center)
		)
	}
	
	var routes: some View {
		let tabRoutes = self.viewRouter.tabRoutes
		let currentView = self.viewRouter.currentView
		
		return (
			Group {
				if currentView == tabRoutes[0].type {
					tabRoutes[0]
						.screen
						.transition(.opacity)
				}
				
				else if currentView == tabRoutes[1].type {
					tabRoutes[1]
					.screen
					.transition(.opacity)
				}
				
				else if currentView == tabRoutes[2].type {
					tabRoutes[2]
					.screen
					.transition(.opacity)
				}
				
				else if currentView == tabRoutes[3].type {
					tabRoutes[3]
					.screen
					.transition(.opacity)
				}
				
				else if currentView == tabRoutes[4].type {
					tabRoutes[4]
					.screen
					.transition(.opacity)
				}
			}
		)
		
	}
	
	var body: some View {
		let tabRoutes = self.viewRouter.tabRoutes
		
		return (
			GeometryReader { geometry in
				VStack(spacing: 0) {
					self.routes
					HStack(alignment: .center, spacing: 0) {
						ForEach(tabRoutes.indices) { index in
							self.getTabIcon(geometry, tab: tabRoutes[index])
						}
					}
					.frame(width: geometry.size.width, height: geometry.size.height / 10)
				}
			}
		)
	}
}

struct TabsScreen_Previews: PreviewProvider {
	
	static var previews: some View {
		TabsScreen()
	}
}
