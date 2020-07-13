//
//  FormModel.swift
//  swiftui-escola
//
//  Created by João Damazio on 02/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import UIKit

class FormModel: ObservableObject {
	@Published var inputs: [FormInputModel] = []
	@Published var onSubmit: () -> Void = { () in }

	init(inputs: [FormInputModel]) {
		let indexLast = inputs.count - 1
		
		for (index, input) in inputs.enumerated() {
			input.onKeyboardReturn = { () in
				input.validationRule = FormRules.checkInputIsValid(input: input)
			
				if input.validationRule != nil {
					input.howManyAttempts += 1
				}
				
				else {
					if index == indexLast {
						self.onSubmit()
					}
								
					else {
						let _ = inputs[index + 1].becomeFirstResponder()
					}
				}
			}
		 }

		self.inputs = inputs
	}
	
	func checkFormIsValid() -> Bool {
		var isSucess = true

		for i in self.inputs.indices {
			self.inputs[i].validationRule = FormRules.checkInputIsValid(input: self.inputs[i])
			
			if self.inputs[i].validationRule != nil {
				if isSucess {
					self.inputs[i].howManyAttempts += 1
					let _ = self.inputs[i].becomeFirstResponder()
				}
				
				isSucess = false
			}
		}
		
		return isSucess
	}	
}

class FormInputModel: ObservableObject {
	@Published var name: String
	@Published var placeholder: String
	@Published var value: String
	@Published var isPassword: Bool
	@Published var keyboardReturnText: UIReturnKeyType
	@Published var onKeyboardReturn: () -> Void
	@Published var keyboardType: UIKeyboardType
	@Published var rules: [FormRulesModel]
	@Published var validationRule: (FormRulesModel)?
	@Published var hasFocus: Bool
	@Published var hasEverUnfocused: Bool
	@Published var howManyAttempts: Int
	@Published var becomeFirstResponder: () ->  Bool
	

	init(
		name: String,
		placeholder: String,
		value: String = "",
		isPassword: Bool = false,
		keyboardReturnText: UIReturnKeyType = .done,
		keyboardType: UIKeyboardType = .default,
		rules: [FormRulesModel] = [],
		validationRule: (FormRulesModel)? = nil
	){
		self.name = name
		self.placeholder = placeholder
		self.value = value
		self.isPassword = isPassword
		self.keyboardReturnText = keyboardReturnText
		self.onKeyboardReturn = { () in }
		self.keyboardType = keyboardType
		self.rules = rules
		self.validationRule = validationRule
		self.hasFocus = false
		self.hasEverUnfocused = false
		self.howManyAttempts = 0
		self.becomeFirstResponder = { () in return true }
	}
	
	func changeFocus(_ hasFocus: Bool) {
		if hasFocus {
			self.hasFocus = true
		} else {
			self.hasFocus = false
			self.hasEverUnfocused = true
			self.validationRule = FormRules.checkInputIsValid(input: self)
		}
	}
	
	func getColor() -> UIColor {
		var color = CustomColor.borderInputColor
		
		if((self.hasEverUnfocused || self.howManyAttempts > 0) && self.validationRule != nil) {
			if(self.hasFocus) {
				color = CustomColor.warning
			}
			
			else {
				color = CustomColor.danger
			}
		}
		
		else if((self.value != "" || self.howManyAttempts > 0) && self.validationRule == nil) {
			color = CustomColor.success
		}
		
		return color
	}

}

class FormRulesModel: ObservableObject {
	@Published var name: FormRulesNames
	@Published var message: String
	@Published var optionalParam: (Any)? = nil
	
	init(name: FormRulesNames, message: String, optionalParam: (Any)? = nil) {
		self.name = name
		self.message = message
		self.optionalParam = optionalParam
	}

}
