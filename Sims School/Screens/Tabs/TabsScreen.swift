//
//  TabsScreen.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TabsScreen: View {
	@ObservedObject var viewRouter = ViewRouter()
	
	func getActualRoute() -> AnyView {
		return AnyView(viewRouter.tabRoutes[viewRouter.currentView]?.screen)
	}
	
	func getTabIcon(_ geometry: GeometryProxy, tab: TabInformation) -> some View {
		let currentView = self.viewRouter.currentView
		let countTab = CGFloat(self.viewRouter.tabRoutes.count)
		let widthTab = geometry.size.width / countTab
		
		return
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
						.frame(width: 25, height: 25)
						.foregroundColor(currentView == tab.type ? .blue : .gray)
						.padding(.bottom, 2)

					Text(tab.name)
						.foregroundColor(currentView == tab.type ? .blue : .gray)
						.font(.system(size: 12, weight: .medium, design: .default))
						.padding(.top, 2)
					
					Spacer()
				}
		}
		.frame(width: widthTab, height: geometry.size.height / 10, alignment: .center)
	}
		
	var body: some View {
		GeometryReader { geometry in
			VStack {
				self.getActualRoute()
				HStack(alignment: .center, spacing: 0) {
					self.getTabIcon(geometry, tab: self.viewRouter.tabRoutes[.HomeScreen]!)
					self.getTabIcon(geometry, tab: self.viewRouter.tabRoutes[.ScoresScreen]!)
					self.getTabIcon(geometry, tab: self.viewRouter.tabRoutes[.ClassesScreen]!)
					self.getTabIcon(geometry, tab: self.viewRouter.tabRoutes[.TipsScreen]!)
					self.getTabIcon(geometry, tab: self.viewRouter.tabRoutes[.MenuScreen]!)
				}
				.frame(width: geometry.size.width, height: geometry.size.height / 10)
			}
		}
	}
}

struct TabsScreen_Previews: PreviewProvider {
	static var previews: some View {
		TabsScreen()
	}
}
