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
		onSucess: @escaping (_ response: UserResponse) -> Void,
		onError: @escaping (_ error: AuthErrorCode) -> Void
	) {
		FirebaseAuth.Auth.auth().signIn(withEmail: user.email, password: user.password) { (result, error) in
			if let res = result {
				onSucess(UserResponse.init(
					uid: res.user.uid,
					email: res.user.email!,
					photoURL: res.user.photoURL,
					name: res.user.displayName!
				))
			}
			else if let err = error{
				print("valueeeeee", err._code)
				onError(AuthErrorCode(rawValue: err._code)!)
			}
		}
	}
}


