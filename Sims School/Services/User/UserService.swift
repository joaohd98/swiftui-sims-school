//
//  Service.swift
//  Sims School
//
//  Created by João Damazio on 05/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import FirebaseAuth

class UserService {
	static func signIn(
		user: UserRequest,
		onSucess: @escaping (_ user: UserResponse) -> Void,
		onError: @escaping (_ error: AuthErrorCode) -> Void
	) {
		Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
			if let res = result {

				let db = FirebaseDatabase.db
				let docUser = db.collection("user").document(res.user.uid)

				docUser.getDocument { (document, error) in
					if let document = document, document.exists, var dictionary = document.data() {
						
						let group = DispatchGroup()
						
						dictionary["uid"] = res.user.uid
						let response = UserResponse(dictionary: dictionary, group: group)
						
						group.notify(queue: .main) {
							onSucess(response)
						}
					}
						
					else {
						onError(AuthErrorCode(rawValue: 0)!)
					}
				}

			}
			else if let err = error{
				onError(AuthErrorCode(rawValue: err._code)!)
			}
		}
	}
	
	static func updatePicture(user: UserResponse, refURL: String, onComplete: @escaping (_ error: Error?) -> Void) {
		let db = FirebaseDatabase.db
		let docUser = db.collection("user").document(user.uid)
	
		docUser.updateData(["profile_picture": refURL]) { (error) in
			if error != nil {
				onComplete(error)
				return
			}
			
			ImageLoader.cache.removeObject(forKey: refURL as NSString)
			
			onComplete(nil)
		}
	}
}


