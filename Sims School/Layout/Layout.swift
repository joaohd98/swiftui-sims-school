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
	@FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var users: FetchedResults<UserEntity>
    @EnvironmentObject var firebaseSession: FirebaseSession

	var body: some View {		
		return (
			ZStack {
				if users.count > 0 && firebaseSession.isLogged  {
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
