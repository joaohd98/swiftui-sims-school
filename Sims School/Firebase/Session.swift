import SwiftUI
import Firebase
import FirebaseAuth

class FirebaseSession: ObservableObject {
	@Published var isLogged: Bool = Auth.auth().currentUser != nil

	init() {
//		let user = Auth.auth().currentUser
//
//		if user != nil {
//			FirebaseDatabase().initFirebaseDataBase(currentUser: user)
//		}

	}

	func login() {
		self.isLogged = true
	}
	
	func logout() {
		self.isLogged = false
	}
}
