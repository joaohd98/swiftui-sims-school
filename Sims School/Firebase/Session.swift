import SwiftUI
import Firebase
import FirebaseAuth

class FirebaseSession: ObservableObject {
	@Published var isLogged: Bool = Auth.auth().currentUser != nil
	let defaults = UserDefaults.standard

	init() {
		let user = Auth.auth().currentUser

		if user != nil {
			FirebaseDatabase().initFirebaseDataBase(currentUser: user)
		}
	}

	func login() {
		defaults.set(true, forKey: "isLogged")
		self.isLogged = true
	}
	
	func logout() {
		defaults.set(false, forKey: "isLogged")
		self.isLogged = false
	}
}
