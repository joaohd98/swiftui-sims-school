//
//  CustomInputView.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct Shake: GeometryEffect {
    var amount: CGFloat = 30
    var shakesPerUnit = 2
    var animatableData: CGFloat

    func effectValue(size: CGSize) -> ProjectionTransform {
        ProjectionTransform(CGAffineTransform(translationX:
            amount * sin(animatableData * .pi * CGFloat(shakesPerUnit)),
            y: 0))
    }
}

fileprivate struct CustomTextField : TextFieldStyle {
	var input: FormInputModel

	public func _body(configuration: TextField<Self._Label>) -> some View {
		
		let color = self.input.getColor()
		
		return (
			configuration
				.padding(.vertical, 8)
				.padding(.horizontal, 10)
				.foregroundColor(CustomColor.inputColor)
				.font(.system(size: 13, weight: .medium, design: .rounded))
				.background(
					RoundedRectangle(cornerRadius: 10)
						.strokeBorder(color, lineWidth: 1)
				)
				.modifier(Shake(animatableData: CGFloat(self.input.submitWhenInvalid ? 10 : 0)))
		)
	
	}
}


struct CustomInput: View {
	@ObservedObject var input: FormInputModel

	func onAppear() {
		self.input.bindingValue = Binding<String>(get: {
			self.input.value
		}, set: {
			self.input.value = $0
			self.input.validationRule = FormRules.checkInputIsValid(input: self.input)
		})
	}
	
    var body: some View {
		let color = self.input.getColor()
		let message = color == CustomColor.danger ||  color == CustomColor.warning ? self.input.validationRule!.message : ""
		
		return (
			VStack(alignment: .leading, spacing: 2.0) {
				if self.input.isPassword {
					SecureField(input.placeholder, text: self.input.bindingValue!)
						.textFieldStyle(CustomTextField(input: self.input))
				}
				else {
					TextField(input.placeholder, text: self.input.bindingValue!, onEditingChanged: {hasFocus in self.input.changeFocus(hasFocus)})
					.keyboardType(self.input.keyboardType)
					.textFieldStyle(CustomTextField(input: self.input))
				}
		
				Text(message)
					.foregroundColor(color)
					.font(.system(size: 12, weight: .medium, design: .rounded))
					.padding(.horizontal, 7)
			}.padding(.horizontal, 7)
		)
		.onAppear{ self.onAppear() }
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
