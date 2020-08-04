//
//  MenuScreenOption.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct MenuScreenOptions: View {
	@Binding var options: [(text: String, image: Image)]
	@Binding var currentView: TabsRoutes
	@State var goLocation: Bool = false
	@State var isSharing: Bool = false
	
	func onClick(text: String) {
		switch text {
		case "Home":
			self.currentView = .HomeScreen
			break
			
		case "Score":
			self.currentView = .ScoresScreen
			break
			
		case "Classes":
			self.currentView = .ClassesScreen
			break
			
		case "Tips":
			self.currentView = .TipsScreen
			break
			
		case "Location":
			self.goLocation.toggle()
			break
			
		case "Share":
			self.isSharing.toggle()
			break
			
		default:
			break
		}
	}
	
	func getCard(_ card: (text: String, image: Image)) -> AnyView {
		if card.text == "Location" {
			return AnyView(NavigationLink(destination: LocationScreen().navigationBarTitle("Maps"), isActive: self.$goLocation) {
				self.cardContent(card)
			})
		}
			
		else if card.text == "Share" {
			let shareText = """
			Hey,

			Sims School is a simple swiftui app, that I created with so much care

			See the source code at: https://github.com/joaohd98/swiftui-school
			"""
			
			return AnyView(self.cardContent(card).sheet(isPresented: self.$isSharing) {
				ShareSheet(activityItems: [shareText.trimmingCharacters(in: .whitespacesAndNewlines)])
			})
		}
		
		return AnyView(self.cardContent(card))
		
	}
	
	func cardContent(_ card: (text: String, image: Image)) -> some View {
		Button(action: {
			self.onClick(text: card.text)
		}) {
			VStack(alignment: .leading, spacing: 15) {
				card.image
					.resizable()
					.aspectRatio(contentMode: .fit)
					.frame(width: 24, height: 24)
					.foregroundColor(Color.blue)
				Text(card.text)
					.foregroundColor(Color.blue)
			}
			.frame(width: UIScreen.screenWidth / 2 - 60, alignment: .leading)
			.padding()
			.background(Color(UIColor { (trait) -> UIColor in
			   return trait.userInterfaceStyle == .dark ? .black : .white
			}))
			.cornerRadius(15)
			.shadow(color: Color(UIColor { (trait) -> UIColor in
			   return trait.userInterfaceStyle == .dark ? .white : .black
			}), radius: 2.5, x: 0, y: 2)
		}
	}
	
	var body: some View {
		var optionsIndex: [Int] = []
		
		stride(from: 1, to: self.options.count , by: 2).forEach { value in
			optionsIndex.append(value)
		}
		
		return (
			VStack(alignment: .leading) {
				ForEach(optionsIndex.indices) { index in
					HStack {
						self.getCard(self.options[optionsIndex[index] - 1])
						Spacer()
						self.getCard(self.options[optionsIndex[index]])
					}
					.padding(.vertical, UIScreen.screenHeight * 0.02)
				}
			}
		)
		
	}
}

struct MenuScreenOptions_Previews: PreviewProvider {
	@State static var options: [(text: String, image: Image)] = []
	@State static var currentView: TabsRoutes = .MenuScreen
	
	static var previews: some View {
		MenuScreenOptions(options: $options, currentView: self.$currentView)
	}
}
