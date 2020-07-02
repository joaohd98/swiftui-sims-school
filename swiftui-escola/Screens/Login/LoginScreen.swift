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
		InputModel.init(
			name: "email",
			placeholder: "Email",
			rules: [
				RulesModel.init(
					name: "email",
					message: "Digite um email válido!"
				),
			]
		),
		InputModel.init(
			name: "password",
			placeholder: "Senha",
			rules: [
				RulesModel.init(
					name: "min-value",
					message: "Digite um senha com no mínimo 4 digitos!",
					optionalParam: 4
				),
				RulesModel.init(
					name: "max-value",
					message: "Digite um senha com no máximo 8 digitos!",
					optionalParam: 8
				),
			]
		)
	])
	
    var body: some View {
		VStack(alignment: .center, spacing: 30) {
			CustomImages.logo.resizable().frame(width: 150, height: 150)
			CustomInputView(textValue: "", placeholder: "Email")
			CustomInputView(textValue: "", placeholder: "Senha")
			Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
				Text("Fazer login")
					.padding(.vertical, 12)
					.padding(.horizontal, 30)
					.foregroundColor(CustomColor.white)
					.background(CustomColor.link)
					.cornerRadius(15)


			}
			.padding(.top, 10)
		}
		.padding(.horizontal)
		.padding(.bottom, 100)
		.keyboardAdaptive() 
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
