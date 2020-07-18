//
//  ClassesScreenDaysWeek.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ClassesScreenDaysWeek: View {
	let weekdays = ["S", "M", "T", "W", "T", "F", "S"]

	func getFontColor(index: Int) -> Color? {
		weekdays[index] == "S" ? Color(CustomColor.gray) : nil
	}
	
    var body: some View {
		HStack {
			ForEach(weekdays.indices) {
				Spacer()
				Text(self.weekdays[$0])
					.foregroundColor(self.getFontColor(index: $0))
					.font(.system(size: 16, weight: .bold))
					.frame(width: 40, height: 40, alignment: .center)
				Spacer()
			}
		}
		.padding(.top, 10)
		.padding(.bottom, 5)
		
	}
}

struct ClassesScreenDaysWeek_Previews: PreviewProvider {
    static var previews: some View {
        ClassesScreenDaysWeek()
    }
}
