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
					if let document = document, document.exists, var data = document.data() {
						data["uid"] = res.user.uid
						onSucess(UserResponse(data: data))
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
}


