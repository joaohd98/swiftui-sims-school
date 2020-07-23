//
//  Login.swift
//  Sims School
//
//  Created by João Damazio on 22/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import Firebase
import FirebaseAuth

class FirebaseLogin: ObservableObject {
	@Published var user: UserResponse?
	
	func login(user: User) {
		self.user = self.setUser(user: user)
	}
	
	func logout() {
		
	}
	
	func listener() {
		
		Auth.auth().addStateDidChangeListener { (auth, user) in
			if let user = user {
				self.session = self.setUser(user: user)
			} else {
				self.session = nil
			}
		}
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
