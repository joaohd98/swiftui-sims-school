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
	@State var currentUser: User? = Auth.auth().currentUser
	
	var body: some View {
		if currentUser != nil {
			return AnyView(TabsScreen(currentUser: self.$currentUser))
		} else {
			return AnyView(LoginScreen(currentUser: self.$currentUser))
		}
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView()
    }
}
