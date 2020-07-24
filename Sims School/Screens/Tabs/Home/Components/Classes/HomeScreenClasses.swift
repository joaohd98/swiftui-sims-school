//
//  HomeScreenProfileClasses.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenClasses: View {
	@Binding var classes: [ClassResponse]
	@State var currentClass: Int
	
	func getCard(actualClass: ClassResponse) -> some View {
		VStack(alignment: .leading, spacing: 10) {
			HStack(alignment: .center, spacing: 0) {
				Spacer()
				Text("22/07/3030 - \(actualClass.weekDay)")
					.foregroundColor(Color(CustomColor.white))
					.font(.system(size: 14, weight: .medium))
				Spacer()
			}
			.padding(.vertical, 5)
			.background(Color(CustomColor.gray))

			Text("\(actualClass.course)")
				.foregroundColor(Color(CustomColor.gray))
				.font(.system(size: 16, weight: .bold))
				.multilineTextAlignment(.leading)
				.padding(.horizontal, 10)

			Text("\(actualClass.teacher)")
				.foregroundColor(Color(CustomColor.gray))
				.font(.system(size: 16, weight: .medium))
				.multilineTextAlignment(.leading)
				.padding(.horizontal, 10)

			HStack(alignment: .center) {
				Spacer()
				Text("\(actualClass.place)")
					.font(.system(size: 14, weight: .bold))
				Spacer()
			}
			.padding(.vertical, 10)
		}
		.border(Color.gray, width: 1)
		.padding()
	}
    var body: some View {
		SlideHorizontal(
			classes.map { self.getCard(actualClass: $0) },
			hasDots: true
		)
		.frame(height: 170)
		.padding(.top, 10)
		.padding(.bottom, 20)
    }
}

struct HomeScreenClasses_Previews: PreviewProvider {
	@State static var classes: [ClassResponse] = []
	@State static var currentClass: Int = 3
	
    static var previews: some View {
        HomeScreenClasses(classes: $classes, currentClass: currentClass)
    }
}
