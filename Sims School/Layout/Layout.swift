//
//  Layout.swift
//  Sims School
//
//  Created by João Damazio on 13/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct LayoutView: View {
    @EnvironmentObject var firebaseSession: FirebaseSession

	var body: some View {		
		return (
			ZStack {
				if firebaseSession.user != nil  {
					AnyView(TabsScreen())
						.transition(.scale)

				} else {
					AnyView(LoginScreen())
						.transition(.scale)
				}
			}
		)
	}
	
}

struct Layout_Previews: PreviewProvider {
	static var previews: some View {
		LayoutView()
	}
}
