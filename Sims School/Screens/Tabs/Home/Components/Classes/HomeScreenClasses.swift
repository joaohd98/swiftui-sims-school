//
//  HomeScreenProfileClasses.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenClasses: View {
    var body: some View {
		HStack(spacing: 0) {
			Spacer()
			VStack(alignment: .center) {
				VStack(alignment: .leading, spacing: 10) {
					HStack(alignment: .center, spacing: 0) {
						Spacer()
						Text("22/07/3030 - Quarta")
							.foregroundColor(Color(CustomColor.white))
							.font(.system(size: 16, weight: .medium))
						Spacer()
					}
					.padding(.vertical, 5)
					.background(Color(CustomColor.gray))

					Text("Gestão de projeto - Agile")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))
						.multilineTextAlignment(.leading)
						.padding(.horizontal, 10)

					Text("Renato silva de lima")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .medium))
						.multilineTextAlignment(.leading)
						.padding(.horizontal, 10)

					HStack(alignment: .center) {
						Spacer()
						Text("Paulista 7 - lab. 706")
							.font(.system(size: 14, weight: .bold))
						Spacer()
					}
					.padding(.vertical, 10)

				}
				.border(Color.gray, width: 1)

				HStack(alignment: .center, spacing: 15) {
					Image(systemName: "circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 10, height: 10)
					Image(systemName: "circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 10, height: 10)
					Image(systemName: "circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 10, height: 10)
					Image(systemName: "circle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 10, height: 10)
					Image(systemName: "circle.fill")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 10, height: 10)
				}
			}
			Spacer()
		}
		.padding()
    }
}

struct HomeScreenClasses_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenClasses()
    }
}
