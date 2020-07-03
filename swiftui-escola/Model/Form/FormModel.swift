//
//  FormModel.swift
//  swiftui-escola
//
//  Created by João Damazio on 02/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import UIKit

class FormModel {
	var inputs: [FormInputModel]
	
	init(inputs: [FormInputModel]) {
		self.inputs = inputs
	}
	
	func checkFormIsValid() -> Bool {
		
		for i in self.inputs.indices {
			
			self.inputs[i].validationRule = FormRules.checkInputIsValid(input: self.inputs[i])
			
			print(self.inputs[i].validationRule ?? "Nil")
			
			if self.inputs[i].validationRule != nil {
				self.inputs[i].onWrongAttemptSubmit!()
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

struct FormInputModel {
	var name: String = ""
	var placeholder: String = ""
	var value = ""
	var bindingValue: Binding<String>? = nil
	var isPassword = false
	var submitWhenInvalid = false
	var keyboardType: UIKeyboardType = .default
	var rules: [FormRulesModel] = []
	var validationRule: (FormRulesModel)? = nil
	var onWrongAttemptSubmit: (() -> Void)? = nil
}

struct FormRulesModel {
	var name: FormRulesNames
	var message: String
	var optionalParam: (Any)? = nil
}
