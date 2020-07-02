//
//  CustomInputView.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

fileprivate struct CustomTextField : TextFieldStyle {
		
  public func _body(configuration: TextField<Self._Label>) -> some View {
    configuration
		.padding(.vertical, 8)
		.padding(.horizontal, 10)
		.foregroundColor(CustomColor.inputColor)
		.font(.system(size: 13, weight: .medium, design: .rounded))
		.background(
			RoundedRectangle(cornerRadius: 10)
				.strokeBorder(CustomColor.borderInputColor, lineWidth: 1)
		)
	
	}
}

struct CustomInput: View {
	@State var input: FormInputModel
	
    var body: some View {
		let binding = Binding<String>(get: {
			self.input.value
		}, set: {
			self.input.value = $0
			self.input.validationRule = FormRules.checkFormIsValid(input: self.input)
 		})
				
		return (
			VStack(alignment: .leading, spacing: 2.0) {
				if self.input.isPassword {
					SecureField(input.placeholder, text: binding)
						.textFieldStyle(CustomTextField())
				}
				else {
					TextField(input.placeholder, text: binding)
						.textFieldStyle(CustomTextField())
				}
		
				Text(self.input.validationRule != nil ? self.input.validationRule!.message : "")
					.foregroundColor(CustomColor.danger)
					.font(.system(size: 12, weight: .medium, design: .rounded))
					.padding(.horizontal, 7)
			}.padding(.horizontal, 7)
		)
	}
	
}


struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
		CustomInput(
			input: FormInputModel.init(name: "nome", placeholder: "Nome")
		)
		.previewLayout(.fixed(width: 300, height: 100))
    }
}
