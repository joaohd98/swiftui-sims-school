//
//  Layout.swift
//  Sims School
//
//  Created by João Damazio on 13/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct LayoutView: View {
	var body: some View {
		if Auth.auth().currentUser == nil {
			return AnyView(TabsScreen())
		} else {
			return AnyView(LoginScreen())
		}
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView()
    }
}
