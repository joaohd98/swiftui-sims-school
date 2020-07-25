//
//  HomeScreenProfile.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenProfile: View {
	@Environment(\.imageCache) var cache: ImageCache
	@Binding var user: UserResponse?
	
	var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			URLImage(url: user?.cover_picture, cache: cache, configuration: { $0.resizable() })
				.frame(
					width: UIScreen.screenWidth,
					height: 125
			)
			VStack(alignment: .leading, spacing: 5) {
				ZStack(alignment: .leading) {
					URLImage(url: user?.profile_picture, cache: cache, configuration: { $0.resizable() })
						.frame(
							width: 75,
							height: 75
						)
						.cornerRadius(75)
				}
				.padding(.all, 3)
				.background(Color(UIColor.init { (trait) -> UIColor in
					return trait.userInterfaceStyle == .dark ? .white : .black
				}))
				.cornerRadius(75)
				VStack(alignment: .leading, spacing: 5) {
					Text(self.user?.name ?? "")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))
					
					HStack {
						Text("RM:")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 16, weight: .bold))
						
						Text(self.user?.rm ?? "")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .semibold))
						
					}
				}
				.padding(.leading, 95)
				.padding(.top, -40)
				
				HStack(alignment: .firstTextBaseline) {
					Text("Turma:")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))
					
					Text(self.user?.actual_class ?? "")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 14, weight: .semibold))
				}
				.padding(.top, 5)
				
				Text(self.user?.course ?? "")
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 16, weight: .bold))
			}
			.padding()
			.padding(.top, -60)
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
