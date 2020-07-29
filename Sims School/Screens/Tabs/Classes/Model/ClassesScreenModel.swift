//
//  ClassScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 18/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth

class ClassesScreenModel: ObservableObject {
	var user: UserResponse? = nil
	var firstRun: Bool = true
	@Published var calendarStatus: NetworkRequestStatus = .loading
	@Published var calendar: [CalendarResponse] = []
	@Published var courseSelected: CalendarCourseResponse = CalendarCourseResponse()
	@Published var isModalVisible: Bool = false

	func initProps(users: FetchedResults<UserEntity>, calendar: FetchedResults<CalendarEntity>) {
		if firstRun {
			self.getUserRequest(users: users)
			self.getCalendarRequest(calendar: calendar)
			firstRun.toggle()
		}
	}
	
	func getUserRequest(users: FetchedResults<UserEntity>) {
		if users.count > 0 {
			self.user = UserResponse(user: users[0])
		}
	}
	
	func getCalendarRequest(calendar: FetchedResults<CalendarEntity>) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			if let id_class = self.user?.id_class {
				CalendarService.getCalendar(
					request: CalendarRequest(id_class: id_class),
					onSucess: { calendar in
						self.calendar = calendar
						self.calendarStatus = .success
					},
					onError: {
						self.calendarStatus = .failed
					})
			}
		}
	}

}
 
