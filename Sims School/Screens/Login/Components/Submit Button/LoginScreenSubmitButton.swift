//
//  LoginScreenSubmitButton.swift
//  Sims School
//
//  Created by João Damazio on 10/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import FirebaseAuth

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

struct LoginScreenSubmitButton: View {
	@Binding var isLoading: Bool
	@State var onButtonPress: (_ onError: @escaping (_ errorCode: AuthErrorCode?) -> Void) -> Void
	@State var showAlert: Bool = false
	@State var errorCode: AuthErrorCode? = nil

	var body: some View {
		Button(action: {
			withAnimation {
				self.onButtonPress({ errorCode in
					self.showAlert.toggle()
					self.errorCode = errorCode
				})
			}
		}) {
			if self.isLoading {
				ActivityIndicator()
			}
			else {
				Text("Entrar")
			}
		}
		.alert(isPresented: self.$showAlert) {
			let errorCode = self.errorCode!
			
			if errorCode == .some(.missingEmail) || errorCode == .some(.userNotFound) {
				return Alert(
					title: Text("Email incorreto"),
					message: Text("O email que você entrou não pertence a nenhuma conta. Por favor, verifique o endereco de email e tente novamente."),
					dismissButton: .default(Text("OK"))
				)

			}
			
			else if errorCode == .some(.wrongPassword) {
				return Alert(
					title: Text("Senha incorreta"),
					message: Text("A senha que você entrou está incorreta. Por favor tente novamente."),
					dismissButton: .default(Text("OK"))
				)
			}
			
			else {
				return Alert(
					title: Text("Algo errado aconteceu"),
					message: Text("Ocorreu um erro interno. Por favor tente novamente."),
					dismissButton: .default(Text("OK"))
				)
			}
		}
		.disabled(self.isLoading)
		.buttonStyle(SubmitButton(isLoading: self.isLoading))
		.padding(.top, 20)
	}
}

struct LoginScreenSubmitButton_Previews: PreviewProvider {
	
	@State static var isLoading: Bool = false
	static func onSubmitLogin(onError: @escaping (_ errorCode: AuthErrorCode) -> Void = {_ in }) {}
	
    static var previews: some View {
        LoginScreenSubmitButton(
			isLoading: self.$isLoading,
			onButtonPress: self.onSubmitLogin
		)
    }
}
