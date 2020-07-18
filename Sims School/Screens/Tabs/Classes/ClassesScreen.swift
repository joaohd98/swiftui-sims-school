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
	@State var showModal: Bool = false

	var body: some View {
		CustomContainerSignIn {
			Group {
				ZStack {
					VStack(spacing: 0) {
						Button(action: {
							self.showModal.toggle()
						}) {
							ClassesScreenDaysWeek()
						}
						ClassesScreenCalendar()
					}
					.opacity(self.showModal ? 0.2 : 1)
					SliderOverView(isVisible: self.$showModal) {
						ClassesScreenSubjectDay()
					}
				}
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
