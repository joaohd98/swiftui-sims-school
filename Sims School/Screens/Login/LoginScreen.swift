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
	@ObservedObject var props = LoginScreenModel()
	
	func onSubmitLogin(onError: @escaping (_ errorCode: AuthErrorCode) -> Void = {_ in }) {
		UIApplication.shared.endEditing()

		if self.props.form.checkFormIsValid() {
			self.props.isLoading.toggle()
			
			let user = UserRequest.init(
				email: self.props.form.inputs[0].value,
				password: self.props.form.inputs[1].value
			)

			UserService.signIn(user: user, onSucess: { (user) in

			}) { (err) in
				self.props.isLoading.toggle()
				onError(err)
			}
		}
	}
	
    var body: some View {
		CustomContainer {
			VStack(alignment: .center, spacing: 10) {
				LoginScreenLogo()
				ForEach(self.props.form.inputs.indices) { index in
					CustomInput(input: self.props.form.inputs[index])
				}
				LoginScreenSubmitButton(
					isLoading: self.$props.isLoading,
					onButtonPress: self.onSubmitLogin
				)
			}
			.padding(.horizontal)
			.keyboardAdaptive()
		}
		.isLoading(self.props.isLoading)
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
