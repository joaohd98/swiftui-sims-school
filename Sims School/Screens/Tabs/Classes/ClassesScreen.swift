//
//  ClassesScreen.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Foundation

struct ClassesScreen: View {
	@FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var users: FetchedResults<UserEntity>
	@FetchRequest(entity: CalendarEntity.entity(), sortDescriptors: []) var calendar: FetchedResults<CalendarEntity>
	@ObservedObject var props: ClassesScreenModel
	
	func viewDidLoad() {
		self.props.initProps(users: self.users, calendar: self.calendar)
	}
	
	var errorView: some View {
		TryAgainView(
			text: "There was an error when trying to get the calendar.",
			onTryAgain: {
				self.props.calendarStatus = .loading
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.props.getCalendarRequest(calendar: self.calendar)
				}
			}
		)
	}
	
	var loadingView: some View {
		LottieAnimation(animationText: "calendar-animation")
			.frame(height: UIScreen.screenHeight)
	}
	
	var successView: some View {
		VStack(spacing: 0) {
			ClassesScreenDaysWeek()
			ClassesScreenCalendar(
				calendar: self.$props.calendar,
				dayOfYear: self.$props.dayOfYear,
				modalVisible: self.$props.isModalVisible
			)
		}
		.navigationBarTitle("Classes", displayMode: .inline)
		.onAppear { self.viewDidLoad()}
		.sheet(isPresented: self.$props.isModalVisible) {
			ClassesScreenSubjectDay(
				calendar: self.props.calendar,
				dayOfYear: self.$props.dayOfYear
			)
		}
	}
	
	var body: some View {
		CustomContainerSignIn {			
			if self.props.calendarStatus == .failed {
				self.errorView
				.transition(.opacity)

			}
			else if self.props.calendarStatus == .loading {
				self.loadingView
					.transition(.opacity)
			}
			else {
				self.successView
					.transition(.opacity)
			}
		}
		.onAppear { self.viewDidLoad() }
	}
}

struct ClassesScreen_Previews: PreviewProvider {
	static let props = ClassesScreenModel()
	
	static var previews: some View {
		ClassesScreen(props: props)
	}
}
