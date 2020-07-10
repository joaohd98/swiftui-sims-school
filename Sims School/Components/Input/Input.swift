//
//  Input.swift
//  Sims School
//
//  Created by João Damazio on 10/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import UIKit

struct InputUI: UIViewRepresentable {
	@ObservedObject var input: FormInputModel

	func makeUIView(context: Context) -> UITextField {
		let textField = UITextField(frame: .zero)
		textField.delegate = context.coordinator
		textField.placeholder = input.placeholder
		textField.text = input.value
		textField.textColor = CustomColor.inputColor
		textField.keyboardType = input.keyboardType
		textField.isSecureTextEntry = input.isPassword
		textField.layer.borderWidth = 1
		textField.layer.cornerRadius = 10
		textField.font = UIFont.systemFont(ofSize: 13, weight: .medium)
				
		return textField
	}

	func updateUIView(_ textField: UITextField, context: Context) {
		let input = self.input
	
		textField.layer.borderColor = input.getColor().cgColor
	}
	
   func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, UITextFieldDelegate {
		var parent: InputUI

		init(_ textField: InputUI) {
			self.parent = textField
		}
		
		func textFieldDidBeginEditing(_ textField: UITextField) {
			self.parent.input.changeFocus(true)
		}
		
		func textFieldDidEndEditing(_ textField: UITextField) {
			self.parent.input.changeFocus(false)
		}
		
		func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
			let input = self.parent.input
			
			input.value = textField.text ?? ""
			input.validationRule = FormRules.checkInputIsValid(input: input)
			
			return true
		}
		
	}
}

struct Input_Previews: PreviewProvider {
    static var previews: some View {
        InputUI(
			input: FormInputModel.init(name: "nome", placeholder: "Nome")
		)
    }
}
