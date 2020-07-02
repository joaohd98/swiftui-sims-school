//
//  FormRules.swift
//  swiftui-escola
//
//  Created by João Damazio on 02/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import UIKit
import SwiftUI
import Combine

enum FormRulesNames {
	case email
	case minLength
	case maxLength
}

class FormRules {
	
	fileprivate func isEmail(text: String) -> Bool {
		let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
		let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
		
		return !emailPred.evaluate(with: text)
	}
	
	fileprivate func minLength(text: String, length: Int) -> Bool {
		return text.count < length
	}
	
	fileprivate func maxLength(text: String, length: Int) -> Bool {
		return text.count > length
	}
	
	
	static func checkFormIsValid(input: FormInputModel) -> (FormRulesModel)? {
		let validations = FormRules.init()
		
		if input.value == "" {
			return nil
		}

		for formRule in input.rules {
			switch formRule.name {
				case .email: do {
					if validations.isEmail(text: input.value) {
						return formRule
					}
				}
				case .minLength: do {
					let length = formRule.optionalParam as! Int
					
					if validations.minLength(text: input.value, length: length) {
						return formRule
					}
				}
				case .maxLength: do {
					let length = formRule.optionalParam as! Int

					if validations.maxLength(text: input.value, length: length) {
						return formRule
					}
				}
			}
		}
		
		return nil
	}
}

