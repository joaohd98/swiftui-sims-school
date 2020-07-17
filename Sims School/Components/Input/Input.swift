//
//  Input.swift
//  Sims School
//
//  Created by João Damazio on 10/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import UIKit

struct UIInput: UIViewRepresentable {
	@ObservedObject var input: FormInputModel

	func makeUIView(context: Context) -> UITextField {
		let textField = UITextField(frame: .zero)
		textField.delegate = context.coordinator
		textField.text = input.value

		textField.attributedPlaceholder = NSAttributedString(
			string: input.placeholder,
			attributes: [NSAttributedString.Key.foregroundColor: CustomColor.gray]
		)
		
		let fontColor = UIColor.init { (trait) -> UIColor in
			return trait.userInterfaceStyle == .dark ? .white : .black
		}
		textField.textColor = fontColor
		textField.returnKeyType = input.keyboardReturnText
		textField.keyboardType = input.keyboardType
		textField.isSecureTextEntry = input.isPassword
		textField.layer.borderWidth = 1
		textField.layer.cornerRadius = 10
		textField.font = UIFont.systemFont(ofSize: 13, weight: .medium)
		textField.setLeftRightPaddingPoints(right: 10, left: 10)
		
		input.becomeFirstResponder = textField.becomeFirstResponder
		 
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
		var parent: UIInput
		var checkForDelete: Bool = false

		init(_ textField: UIInput) {
			self.parent = textField
		}
		
		func textFieldDidBeginEditing(_ textField: UITextField) {
			self.parent.input.changeFocus(true)
		}
		
		func textFieldDidEndEditing(_ textField: UITextField) {
			self.parent.input.changeFocus(false)
		}
		
		func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
			
			self.checkForDelete = false
			
			if let text = textField.text {
			   if textField.isSecureTextEntry && text.count > 0 {
				   self.checkForDelete = true
			   }
			}
		
			return true;
		}
				
		func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
			
			let input = self.parent.input
			
			if (self.checkForDelete && string.count == 0) {
				self.checkForDelete = false;
				
				input.value = ""
			}
			
			else {
				let oldString = (textField.text! as NSString)
				let updatedString = oldString.replacingCharacters(in: range, with: string)

				input.value = updatedString
			}
			
		
			input.validationRule = FormRules.checkInputIsValid(input: input)
			

			return true
		}
		
		func textFieldShouldReturn(_ textField: UITextField) -> Bool {
			self.parent.input.onKeyboardReturn()
			
			return false
		}
		
	}
}

struct Input_Previews: PreviewProvider {
    static var previews: some View {
        UIInput(
			input: FormInputModel.init(name: "nome", placeholder: "Nome")
		)
    }
}
