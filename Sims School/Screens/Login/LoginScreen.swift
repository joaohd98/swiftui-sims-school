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
    @EnvironmentObject var firebaseSession: FirebaseSession
	@ObservedObject var props = LoginScreenModel()
		
	func viewDidLoad() {
		self.props.form.onSubmit = onSubmitLogin
	}
	
	func onSubmitLogin() {
		UIApplication.shared.endEditing()
		
		if self.props.form.checkFormIsValid() {
			self.props.isLoading.toggle()
			
			let user = UserRequest.init(
				email: self.props.form.inputs[0].value,
				password: self.props.form.inputs[1].value
			)

			//oEnF6abrNybgr4XbeWs1YT4XxlW2
			UserService.signIn(user: user, onSucess: { user in
				withAnimation {
					self.firebaseSession.login(user: user)
				}
			}) { (err) in
				self.props.isLoading.toggle()
				self.props.hasError.toggle()
				self.props.errorCode = err
			}
		}
	}
	
    var body: some View {
		CustomContainerGuest {
			VStack(alignment: .center, spacing: 10) {
				LoginScreenLogo()
				ForEach(self.props.form.inputs.indices) { index in
					CustomInput(
						input: self.props.form.inputs[index]
					)
				}
				LoginScreenSubmitButton(
					isLoading: self.$props.isLoading,
					hasError: self.$props.hasError,
					errorCode: self.$props.errorCode,
					onButtonPress: self.onSubmitLogin
				)
			}
			.padding(.horizontal)
			.keyboardAdaptive()
		}
		.isLoading(self.props.isLoading)
		.onAppear(perform: self.viewDidLoad)
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
