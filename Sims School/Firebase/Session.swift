import SwiftUI
import Firebase
import FirebaseAuth

class FirebaseSession: ObservableObject {
	@Published var user: UserResponse?

	init() {
		let user = Auth.auth().currentUser
		
		if user != nil {
			FirebaseDatabase(currentUser: self.setUser(user: user!))
		}
		
		self.user = (user != nil) ? self.setUser(user: user!) : nil
	}

	func login(user: User) {
		self.user = self.setUser(user: user)
	}
	
	func logout() {
		self.user = nil
	}
	
	func setUser(user: User) -> UserResponse {
		UserResponse(
			uid: user.uid,
			email: user.email!,
			photoURL: user.photoURL,
			name: user.displayName!
		)
	}
}
