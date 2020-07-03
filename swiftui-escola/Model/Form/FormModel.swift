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
		
		for i in self.inputs.indices {
			
			self.inputs[i].validationRule = FormRules.checkInputIsValid(input: self.inputs[i])
			
			print(self.inputs[i].validationRule ?? "Nil")
			
			if self.inputs[i].validationRule != nil {
				self.inputs[i].onWrongAttemptSubmit()
				return false
			}
			
		}
		
		return true
	}
	
	func onChangingInput(name: String, newInput: FormInputModel) {
		if 	let index = self.inputs.firstIndex(where: { (input) -> Bool in input.name == name }) {
			self.inputs[index] = newInput
		}
	}
	
}

class FormInputModel: ObservableObject {
	@Published var name: String
	@Published var placeholder: String
	@Published var value: String
	@Published var bindingValue: Binding<String>?
	@Published var isPassword: Bool
	@Published var submitWhenInvalid: Bool
	@Published var keyboardType: UIKeyboardType
	@Published var rules: [FormRulesModel]
	@Published var validationRule: (FormRulesModel)?
	@Published var onWrongAttemptSubmit: (() -> Void)
	
	init(
		name: String,
		placeholder: String,
		value: String = "",
		bindingValue: Binding<String>? = nil,
		isPassword: Bool = false,
		submitWhenInvalid: Bool = false,
		keyboardType: UIKeyboardType = .default,
		rules: [FormRulesModel] = [],
		validationRule: (FormRulesModel)? = nil,
		onWrongAttemptSubmit: (() -> Void)? = nil
	){
		self.name = name
		self.placeholder = placeholder
		self.value = value
		self.isPassword = isPassword
		self.submitWhenInvalid = submitWhenInvalid
		self.keyboardType = keyboardType
		self.rules = rules
		self.validationRule = validationRule
		self.onWrongAttemptSubmit = onWrongAttemptSubmit ?? {}
		self.bindingValue = bindingValue ?? Binding<String>(
			get: {self.value},
			set: {self.value = $0}
		)
	}
	
}

class FormRulesModel: ObservableObject {
	@Published var name: FormRulesNames
	@Published var message: String
	@Published var optionalParam: (Any)? = nil
	
	internal init(name: FormRulesNames, message: String, optionalParam: (Any)? = nil) {
		self.name = name
		self.message = message
		self.optionalParam = optionalParam
	}

}
