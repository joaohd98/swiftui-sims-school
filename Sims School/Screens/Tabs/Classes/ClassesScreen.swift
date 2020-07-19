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
	@ObservedObject var props: ClassesScreenModel = ClassesScreenModel()
	
	var body: some View {
		CustomContainerSignIn {
			VStack(spacing: 0) {
				ClassesScreenDaysWeek()
				ClassesScreenCalendar(modalVisible: self.$props.isModalVisible)
			}
			.sheet(isPresented: self.$props.isModalVisible) {
				ClassesScreenSubjectDay(modalVisible: self.$props.isModalVisible)
			}
			.navigationBarTitle("Classes", displayMode: .inline)
		}
	}
}

struct ClassesScreen_Previews: PreviewProvider {
	static var previews: some View {
		ClassesScreen()
	}
}
