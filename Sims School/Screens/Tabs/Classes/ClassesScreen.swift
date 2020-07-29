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
	
	var body: some View {
		CustomContainerSignIn {			
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
	}
}

struct ClassesScreen_Previews: PreviewProvider {
	static let props = ClassesScreenModel()
	
	static var previews: some View {
		ClassesScreen(props: props)
	}
}
