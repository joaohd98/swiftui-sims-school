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
	var inputs: [InputModel] = []

	init(inputs: [InputModel]) {
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

struct InputModel {
	var name: String
	var placeholder: String
	var value: String = ""
	var rules: [RulesModel] = []
}

struct RulesModel {
	var name: String
	var message: String
	var optionalParam: (Any)? = nil
}
