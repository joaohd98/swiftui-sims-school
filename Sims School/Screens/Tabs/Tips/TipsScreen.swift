//
//  TipsScreen.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsScreen: View {
    var body: some View {
		CustomContainerSignIn {
//			ScrollView {
//				TipsScreenList()
//			}
			TipsScreenFullScreenImage()
			.navigationBarTitle("Tips")
		}
    }
}

struct TipsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TipsScreen()
    }
}
