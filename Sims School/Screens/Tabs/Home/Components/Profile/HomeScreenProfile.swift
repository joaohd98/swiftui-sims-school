//
//  HomeScreenProfile.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenProfile: View {
	@Binding var user: UserResponse?
	
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
					Text(self.user?.name ?? "")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))

					HStack {
						Text("RM:")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .bold))

						Text(self.user?.rm ?? "")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .semibold))

					}
				}
				.padding(.leading, 125)
				.padding(.top, -50)

				HStack(alignment: .firstTextBaseline) {
					Text("Turma:")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))

					Text(self.user?.actual_class ?? "")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .semibold))
				}

				Text(self.user?.course ?? "")
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 16, weight: .bold))
			}
			.padding()
			.padding(.top, -75)
		}
		.padding(.bottom, -20)

    }
}

struct HomeScreenProfile_Previews: PreviewProvider {
	@State static var user: UserResponse? = nil
	
    static var previews: some View {
		HomeScreenProfile(user: self.$user)
			.previewLayout(.fixed(width: UIScreen.screenWidth, height: 300))
    }
}
