//
//  LoginScreen.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import UIKit

fileprivate struct SubmitButton: ButtonStyle {
	@State var isLoading: Bool = false
	
    func makeBody(configuration: Self.Configuration) -> some View {
        configuration.label
            .foregroundColor(Color.white)
			.frame(width: 140, height: 40, alignment: .center)
			.background(CustomColor.link)
            .cornerRadius(20)
			.scaleEffect(configuration.isPressed ? 1.05 : 1.0)
			.opacity((configuration.isPressed || isLoading) ? 0.7 : 1)
		
    }
}

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
			value: "1234",
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
	
    var body: some View {
		CustomContainer {
			VStack(alignment: .center, spacing: 10) {
				CustomImages
					.logo
					.resizable()
					.frame(width: 150, height: 150)
					.padding(.bottom, 25)
				ForEach(self.form.inputs.indices) { index in
					CustomInput(input: self.form.inputs[index])
				}
				Button(action: {
					withAnimation {
						UIApplication.shared.endEditing()

						if self.form.checkFormIsValid() {
							self.isLoading.toggle()
						}

					}
				}) {
					if self.isLoading {
						ActivityIndicator()
					}
					else {
						Text("Entrar")
					}
				}
				.disabled(self.isLoading)
				.buttonStyle(SubmitButton(isLoading: self.isLoading))
				.padding(.top, 20)
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
    static var previews: some View {
        LoginScreen()
    }
}
