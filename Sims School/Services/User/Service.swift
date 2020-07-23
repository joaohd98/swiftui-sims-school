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
		onSucess: @escaping (_ user: User) -> Void,
		onError: @escaping (_ error: AuthErrorCode) -> Void
	) {
		Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
			if let res = result {
				onSucess(res.user)
			}
			else if let err = error{
				onError(AuthErrorCode(rawValue: err._code)!)
			}
		}
	}
}


