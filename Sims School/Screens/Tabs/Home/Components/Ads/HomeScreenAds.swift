//
//  HomeScreenAds.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenAds: View {
    var body: some View {
		Image("cover-ps4")
			.resizable()
			.frame(height: 175)
			.cornerRadius(10)
			.overlay(
				RoundedRectangle(cornerRadius: 10).stroke(Color.black, lineWidth: 0)
			)
			.padding()
    }
}

struct HomeScreenAds_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreenAds()
    }
}
