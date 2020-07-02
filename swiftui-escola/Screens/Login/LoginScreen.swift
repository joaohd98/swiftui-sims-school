//
//  LoginScreen.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {
	let form: FormModel = FormModel.init(inputs: [
		FormInputModel.init(
			name: "email",
			placeholder: "Email",
			rules: [
				FormRulesModel.init(
					name: .email,
					message: "Digite um email válido!"
				),
			]
		),
		FormInputModel.init(
			name: "password",
			placeholder: "Senha",
			rules: [
				FormRulesModel.init(
					name: .minLength,
					message: "Digite um senha com no mínimo 4 digitos!",
					optionalParam: 4
				),
				FormRulesModel.init(
					name: .maxLength,
					message: "Digite um senha com no máximo 8 digitos!",
					optionalParam: 8
				),
			]
		)
	])
	
    var body: some View {
		VStack(alignment: .center, spacing: 10) {
			CustomImages
				.logo
				.resizable()
				.frame(width: 150, height: 150)
				.padding(.bottom, 25)
			ForEach(self.form.inputs, id: \.name) { input in
				CustomInputView(input: input)
			}
			Button(action: {
				
			}) {
				Text("Fazer login")
					.padding(.vertical, 12)
					.padding(.horizontal, 30)
					.foregroundColor(CustomColor.white)
					.background(CustomColor.link)
					.cornerRadius(15)
			}
			.padding(.top, 20)
		}
		.padding(.bottom, 100)
		.padding(.horizontal)
		.keyboardAdaptive()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
