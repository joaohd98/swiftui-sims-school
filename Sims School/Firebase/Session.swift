import SwiftUI
import Firebase
import FirebaseAuth

class FirebaseSession: ObservableObject {
	@Published var isLogged: Bool = Auth.auth().currentUser != nil

	init() {
		
		/*
		 * create database
		 *
			if user != nil {
				self.database.initFirebaseDataBase(currentUser: self.setUser(user: user!))
			}
		 *
		 */
		
		let user = Auth.auth().currentUser
		
		if user != nil {
			FirebaseDatabase().initFirebaseDataBase(currentUser: user)
		}

	}

	func login() {
		self.isLogged = true
	}
	
	func logout() {
		self.isLogged = false
	}
}
