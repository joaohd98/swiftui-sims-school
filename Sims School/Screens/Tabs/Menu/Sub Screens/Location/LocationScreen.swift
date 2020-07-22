//
//  LocationScreen.swift
//  Sims School
//
//  Created by João Damazio on 22/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct LocationScreen: View {
    var body: some View {
		CustomContainerSignIn {
			Text("ABC")
			.navigationBarTitle("Maps")
		}
    }
}

struct LocationScreen_Previews: PreviewProvider {
    static var previews: some View {
        LocationScreen()
    }
}
