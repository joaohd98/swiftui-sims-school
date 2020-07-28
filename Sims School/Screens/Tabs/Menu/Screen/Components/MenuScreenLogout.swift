//
//  MenuScreenLogout.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth
import CoreData

struct MenuScreenLogout: View {
    @EnvironmentObject var firebaseSession: FirebaseSession
	@State var isAlertOpened: Bool = false
	
	func logout() {
		try! Auth.auth().signOut()
		
		CoreDataHelper.shared.deleteAllData()
		self.firebaseSession.logout()
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 15) {
			Divider()
			Button(action: {
				withAnimation {
					
					self.logout()
				}
			}) {
				HStack {
					Image(systemName: "exclamationmark.triangle")
						.resizable()
						.aspectRatio(contentMode: .fit)
						.frame(width: 24, height: 24)
						.foregroundColor(Color(CustomColor.gray))
					
					Text("Sair")
						.foregroundColor(Color(CustomColor.gray))
					
					Spacer()
				}
				.padding(.horizontal, 15)
			}
		}
	}
}

struct MenuScreenLogout_Previews: PreviewProvider {
	static var previews: some View {
		MenuScreenLogout()
	}
}
