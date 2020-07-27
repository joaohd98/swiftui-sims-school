//
//  HomeScreenProfileClasses.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import SkeletonUI

struct HomeScreenClasses: View {
	@Binding var classes: [ClassResponse]
	@Binding var currentClass: Int
	@Binding var status: NetworkRequestStatus
	
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
			VStack(alignment: actualClass.hasClass ? .leading : .center, spacing: 0) {
				HStack(alignment: .center, spacing: 0) {
					Spacer()
					Text("\(dateFormatted) - \(actualClass.weekDay)")
						.foregroundColor(Color(CustomColor.white))
						.font(.system(size: 14, weight: .medium))
					Spacer()
				}
				.padding(.vertical, 5)
				.background(Color(CustomColor.gray))
				.skeleton(with: status == .loading)
				.shape(type: .rectangle)
				.frame(height: 30)
			
				if actualClass.hasClass {
					VStack(alignment: .leading, spacing: 10) {
						Text("\(actualClass.course)")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .bold))
							.multilineTextAlignment(.leading)
							.skeleton(with: status == .loading)
							.multiline(lines: 1, scales: [0: 0.3])
							.frame(height: 10)

						Text("\(actualClass.teacher)")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .medium))
							.multilineTextAlignment(.leading)
							.skeleton(with: status == .loading)
							.multiline(lines: 1, scales: [0: 0.3])
							.frame(height: 10)

					}
					.padding(.horizontal, 10)
					.padding(.vertical, 20)
					
					HStack(alignment: .center) {
						Spacer()
						Text("\(actualClass.place)")
							.font(.system(size: 16, weight: .bold))
							.skeleton(with: status == .loading)
							.frame(height: 12, alignment: .center)
						Spacer()
					}
					.padding(.vertical, 10)
				}
					
				else {
					Text("Não havera aulas nesse dia")
						.font(.system(size: 20, weight: .bold))
						.foregroundColor(Color(CustomColor.gray))
						.padding(.top, 35)
						.padding(.bottom, 45)
				}
			}
			.border(Color.gray, width: 1)
			.padding()
		)
	}
	
	var loadingView: some View {
		VStack {
			self.getCard(actualClass: ClassResponse(), index: 0)
			SlideHorizontalDots(numberOfPages: 7, currentPage: self.$currentClass, isLoading: true)
		}
	}
	
	var successView: some View {
		SlideHorizontal(
			classes.enumerated().map { (index, element) in self.getCard(actualClass: element, index: index) },
			hasDots: true,
			currentPage: self.$currentClass
		)
	}
	
	var body: some View {
		Group {
			if status == .failed {
				
			}
			else if status == .loading {
				loadingView
			}
			else if status == .success {
				successView
			}
		}
		.frame(height: 170)
	}
}

struct HomeScreenClasses_Previews: PreviewProvider {
	@State static var classes: [ClassResponse] = []
	@State static var currentClass: Int = 3
	@State static var status: NetworkRequestStatus = .success
	
	static var previews: some View {
		HomeScreenClasses(classes: $classes, currentClass: $currentClass, status: $status)
	}
}
