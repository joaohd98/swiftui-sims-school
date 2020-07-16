//
//  HomeScreenProfileClasses.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenClasses: View {
	@Binding var classes: [ClassesResponse]
	@State var currentClass: Int
	
	func getCard(index: String) -> some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .center, spacing: 0) {
				Spacer()
				Text("22/07/3030 - Quarta \(index)")
					.foregroundColor(Color(CustomColor.white))
					.font(.system(size: 16, weight: .medium))
				Spacer()
			}
			.padding(.vertical, 5)
			.background(Color(CustomColor.gray))

			Text("Gestão de projeto - Agile \(index)")
				.foregroundColor(Color(CustomColor.gray))
				.font(.system(size: 16, weight: .bold))
				.multilineTextAlignment(.leading)
				.padding(.horizontal, 10)

			Text("Renato silva de lima \(index)")
				.foregroundColor(Color(CustomColor.gray))
				.font(.system(size: 16, weight: .medium))
				.multilineTextAlignment(.leading)
				.padding(.horizontal, 10)

			HStack(alignment: .center) {
				Spacer()
				Text("Paulista 7 - lab. 706 \(index)")
					.font(.system(size: 14, weight: .bold))
				Spacer()
			}
			.padding(.vertical, 10)
		}
		.border(Color.gray, width: 1)
		.padding()
	}
	
	func getPoint(index: Int) -> String {		
		return self.currentClass == index ? "circle.fill" : "circle"
	}
	
    var body: some View {
		HStack(spacing: 0) {
			Spacer()
			VStack(alignment: .center) {
				SlideHorizontal(
					controllers: self.classes.map { UIHostingController(rootView: self.getCard(index: $0.text)) },
					currentPage: $currentClass
				)
				.frame(height: 170)
				HStack(alignment: .center, spacing: 15) {
					ForEach(self.classes.indices) { index in
						Button(action: {
							self.currentClass = index
						}, label: {
							Image(systemName: self.getPoint(index: index))
								.resizable()
								.aspectRatio(contentMode: .fit)
								.frame(width: 15, height: 15)
								.foregroundColor(.blue)
						})
					}
				}
			}
			Spacer()
		}
    }
}

struct HomeScreenClasses_Previews: PreviewProvider {
	@State static var classes: [ClassesResponse] = [
		ClassesResponse(text: "ABC"),
		ClassesResponse(text: "ABC"),
		ClassesResponse(text: "ABC"),
		ClassesResponse(text: "ABC"),
		ClassesResponse(text: "ABC")
	]
	@State static var currentClass: Int = 3
	
    static var previews: some View {
        HomeScreenClasses(classes: $classes, currentClass: currentClass)
    }
}
