//
//  LoginScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 10/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth

class LoginScreenModel: ObservableObject {
	@Published var isLoading: Bool = false
	@Published var hasError: Bool = false
	@Published var errorCode: AuthErrorCode? = nil
	@Published var hasInternetConnection = true
	@Published var form: FormModel = FormModel.init(inputs: [
		FormInputModel.init(
			name: "email",
			placeholder: "Email",
			value: "teste@mail.com",
			keyboardReturnText: .next,
			keyboardType: .emailAddress,
			rules: [
				FormRulesModel.init(
					name: .minLength,
					message: "Por favor, digite o email",
					optionalParam: 0
				),
				FormRulesModel.init(
					name: .email,
					message: "Digite um email válido!"
				),
			]
		),
		FormInputModel.init(
			name: "password",
			placeholder: "Senha",
			value: "abc123",
			isPassword: true,
			rules: [
				FormRulesModel.init(
					name: .minLength,
					message: "Por favor, digite a senha",
					optionalParam: 0
				),
				FormRulesModel.init(
					name: .maxLength,
					message: "A senha pode ter no maximo 8 digitos",
					optionalParam: 8
				),
			]
		)
	])
}
