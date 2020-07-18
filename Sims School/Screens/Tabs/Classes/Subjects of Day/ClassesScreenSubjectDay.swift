//
//  ClassesScreenSubjectDay.swift
//  Sims School
//
//  Created by João Damazio on 17/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ClassesScreenSubjectDay: View {	
    var body: some View {
		CustomContainerSignIn {
			Group {
				HStack(alignment: .firstTextBaseline, spacing: 20) {
					VStack {
						Image(systemName: "person")
						.resizable()
						.frame(width: 25, height: 25, alignment: .center)
						.padding(.top, 10)
					}
					VStack(alignment: .leading) {
						Text("Gestão de projeto - Agile")
						Text("Renato silva de lima")
					}
					Spacer()
				}
				.padding()
			}
			.navigationBarTitle("15, Jun")
		}
	
    }
}

struct ClassesScreenSubjectDay_Previews: PreviewProvider {
    static var previews: some View {
        ClassesScreenSubjectDay()
    }
}
