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
	
	func getDate(weekDay: Int) -> String {
		let cal = Calendar.current
		
		var comps = cal.dateComponents([.weekOfYear, .yearForWeekOfYear], from: Date())
		
		comps.weekday = weekDay
		var dayInWeek = cal.date(from: comps)!
		
		if weekDay == 0 {
			dayInWeek = cal.date(byAdding: .day, value: -7, to: dayInWeek)!
		}
		
		let df = DateFormatter()
		df.dateFormat = "dd/MM/yyyy"
		
		return df.string(from: dayInWeek)

	}
	
	func getCard(actualClass: ClassResponse, index: Int) -> some View {
		let dateFormatted = self.getDate(weekDay: index)
		
		return (
			VStack(alignment: .leading, spacing: 10) {
				HStack(alignment: .center, spacing: 0) {
					Spacer()
					Text("\(dateFormatted) - \(actualClass.weekDay)")
						.foregroundColor(Color(CustomColor.white))
						.font(.system(size: 14, weight: .medium))
					Spacer()
				}
				.padding(.vertical, 5)
				.background(Color(CustomColor.gray))
				.frame(height: 25)
				
				Text("\(actualClass.course)")
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 16, weight: .bold))
					.multilineTextAlignment(.leading)
					.padding(.horizontal, 10)
					.frame(height: 15)
				
				Text("\(actualClass.teacher)")
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 16, weight: .medium))
					.multilineTextAlignment(.leading)
					.padding(.horizontal, 10)
					.frame(height: 15)
				
				HStack(alignment: .center) {
					Spacer()
					Text("\(actualClass.place)")
						.font(.system(size: 14, weight: .bold))
					Spacer()
				}
				.padding(.vertical, 10)
				.frame(height: 30)
				
			}
			.border(Color.gray, width: 1)
			.padding()
		)
	}
	
	var body: some View {
		SlideHorizontal(
			classes.enumerated().map { (index, element) in self.getCard(actualClass: element, index: index) },
			hasDots: true
		)
		.frame(height: 160)
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
