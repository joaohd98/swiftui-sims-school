//
//  ScoresScreen.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ScoresScreen: View {
    var body: some View {
		CustomContainerGuestSignIn {
			Group {
				Text("ScoresScreen")
			}
			.navigationBarTitle("Meu teste", displayMode: .inline)
		}
    }
}

struct ScoresScreen_Previews: PreviewProvider {
    static var previews: some View {
        ScoresScreen()
    }
}
