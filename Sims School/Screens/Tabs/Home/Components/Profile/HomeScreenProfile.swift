//
//  HomeScreenProfile.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenProfile: View {
    var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			Image("cover")
				.resizable()
				.frame(
					width: UIScreen.screenWidth,
					height: 125
				)
			VStack(alignment: .leading, spacing: 5) {
				ZStack(alignment: .leading) {
					Image("camera-plus")
					.resizable()
					.frame(
						width: 75,
						height: 75
					)
				}
				.padding()
				.background(Color.white.shadow(radius: 2))

				VStack(alignment: .leading, spacing: 5) {
					Text("Renan Sobreira Miranda")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .medium))
					
					HStack {
						Text("RM:")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .bold))

						Text("2216105480")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .medium))

					}
				}
				.padding(.leading, 125)
				.padding(.top, -55)

				HStack(alignment: .firstTextBaseline) {
					Text("Turma:")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))

					Text("22CLD")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .medium))
				}

				Text("MBA em Cloud Computing")
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 16, weight: .bold))
			}
			.padding()
			.padding(.top, -75)
		}
		
    }
}

struct HomeScreenProfile_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenProfile()
			.previewLayout(.fixed(width: UIScreen.screenWidth, height: 300))
    }
}
