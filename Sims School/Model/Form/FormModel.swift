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
	@Published var inputs: [FormInputModel]
	
	init(inputs: [FormInputModel]) {
		self.inputs = inputs
	}
	
	func checkFormIsValid() -> Bool {
		var isSucess = true
		var inputs: [FormInputModel] = []
		
		for i in self.inputs.indices {
			self.inputs[i].validationRule = FormRules.checkInputIsValid(input: self.inputs[i])
			self.inputs[i].hasTriedSubmit = true 

			if self.inputs[i].validationRule != nil {
				isSucess = false
			}
			
			inputs.append(self.inputs[i])
		}
		
		self.inputs = inputs
		
		return isSucess
	}	
}

class FormInputModel: ObservableObject {
	@Published var name: String
	@Published var placeholder: String
	@Published var value: String
	@Published var isPassword: Bool
	@Published var keyboardType: UIKeyboardType
	@Published var rules: [FormRulesModel]
	@Published var validationRule: (FormRulesModel)?
	@Published var hasFocus: Bool
	@Published var hasEverUnfocused: Bool
	@Published var hasTriedSubmit: Bool

	init(
		name: String,
		placeholder: String,
		value: String = "",
		isPassword: Bool = false,
		keyboardType: UIKeyboardType = .default,
		rules: [FormRulesModel] = [],
		validationRule: (FormRulesModel)? = nil
	){
		self.name = name
		self.placeholder = placeholder
		self.value = value
		self.isPassword = isPassword
		self.keyboardType = keyboardType
		self.rules = rules
		self.validationRule = validationRule
		self.hasFocus = false
		self.hasEverUnfocused = false
		self.hasTriedSubmit = false
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
		
		if((self.hasEverUnfocused || self.hasTriedSubmit) && self.validationRule != nil) {
			if(self.hasFocus) {
				color = CustomColor.warning
			}
			
			else {
				color = CustomColor.danger
			}
		}
		
		else if((self.value != "" || self.hasTriedSubmit) && self.validationRule == nil) {
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
