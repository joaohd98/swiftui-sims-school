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
	var inputs: [FormInputModel] = []
	
	init(inputs: [FormInputModel]) {
		self.inputs = inputs
	}
	
//	func getFormJson<T>() -> T where T: Comparable {
//		var json: T;
//
//		self.inputs.forEach { (input) in
//			json[input.name] = input.value;
//		}
//
//		return json;
//	}
	
}

struct FormInputModel {
	var name: String
	var placeholder: String
	var value: String = ""
	var rules: [FormRulesModel] = []
	var validationRule: (FormRulesModel)? = nil
}

struct FormRulesModel {
	var name: FormRulesNames
	var message: String
	var optionalParam: (Any)? = nil
}
