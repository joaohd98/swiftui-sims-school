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
	var body: some View {
		CustomContainerGuestSignIn {
			VStack(spacing: 0) {
				ClassesScreenDaysWeek()
				ClassesScreenCalendar()
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
