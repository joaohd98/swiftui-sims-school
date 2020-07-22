//
//  LocationScreen.swift
//  Sims School
//
//  Created by João Damazio on 22/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import MapKit

struct LocationScreen: View {
	@State var region = CLLocationCoordinate2D(latitude: -23.6037231, longitude: -46.7351884)
	
	var body: some View {
		MapView(coordinate: self.region)
			.frame(maxWidth: .infinity, maxHeight: .infinity)
	}
}

struct LocationScreen_Previews: PreviewProvider {
	static var previews: some View {
		LocationScreen()
	}
}
