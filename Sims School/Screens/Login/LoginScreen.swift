//
//  LoginScreen.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import UIKit
import FirebaseAuth

struct LoginScreen: View {
	@State var isLoading: Bool = false
	@ObservedObject var form: FormModel = FormModel.init(inputs: [
		FormInputModel.init(
			name: "email",
			placeholder: "Email",
			value: "teste@mail.com",
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
	
	func onSubmitLogin(onError: @escaping (_ errorCode: AuthErrorCode) -> Void = {_ in }) {
		UIApplication.shared.endEditing()

		if self.form.checkFormIsValid() {
			self.isLoading.toggle()

			let user = UserRequest.init(
				email: self.form.inputs[0].value,
				password: self.form.inputs[1].value
			)

			UserService.signIn(user: user, onSucess: { (user) in

			}) { (err) in
				self.isLoading.toggle()
				onError(err)
			}
		}
	}
	
    var body: some View {
		CustomContainer {
			VStack(alignment: .center, spacing: 10) {
				LoginScreenLogo()
				ForEach(self.form.inputs.indices) { index in
					CustomInput(input: self.form.inputs[index])
				}
				LoginScreenSubmitButton(
					isLoading: self.$isLoading,
					onButtonPress: self.onSubmitLogin
				)
			}
			.padding(.horizontal)
			.keyboardAdaptive()
		}
		.isLoading(self.isLoading)
		.hasHeader(false)
		.onTapGesture {
			UIApplication.shared.endEditing()
		}
	}

}

struct LoginScreen_Previews: PreviewProvider {
	@State var isLoading: Bool = false

    static var previews: some View {
        LoginScreen()
    }
}
