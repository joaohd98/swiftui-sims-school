//
//  MenuScreenLogout.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth

struct MenuScreenLogout: View {
	@Binding var currentUser: User?
	@State var isAlertOpened: Bool = false
	
	func logout() {
		let firebaseAuth = Auth.auth()
		do {
			try firebaseAuth.signOut()
			self.currentUser = nil
		} catch let signOutError as NSError {
			print ("Error signing out: %@", signOutError)
		}
		
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 15) {
			Divider()
			Button(action: {
				self.logout()
			}) {
				HStack {
					Image(systemName: "exclamationmark.triangle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 24, height: 24)
						.foregroundColor(Color(CustomColor.gray))
					
					Text("Sair")
						.foregroundColor(Color(CustomColor.gray))
				}
				.padding(.horizontal, 15)
			}
		}
	}
}

struct MenuScreenLogout_Previews: PreviewProvider {
	@State static var currentUser: User? = Auth.auth().currentUser

	static var previews: some View {
		MenuScreenLogout(currentUser: $currentUser)
	}
}
