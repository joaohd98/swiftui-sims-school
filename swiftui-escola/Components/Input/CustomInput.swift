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
	var wrongAttempt: Bool

	public func _body(configuration: TextField<Self._Label>) -> some View {
		configuration
			.padding(.vertical, 8)
			.padding(.horizontal, 10)
			.foregroundColor(CustomColor.inputColor)
			.font(.system(size: 13, weight: .medium, design: .rounded))
			.background(
				RoundedRectangle(cornerRadius: 10)
					.strokeBorder(self.wrongAttempt ? CustomColor.danger :  CustomColor.borderInputColor, lineWidth: 1)
			)
			.modifier(Shake(animatableData: CGFloat(self.wrongAttempt ? 10 : 0)))
	}
}

struct CustomInput: View {
	@ObservedObject var form: FormModel
	@ObservedObject var input: FormInputModel
	@State var wrongAttempt: Bool = false

	func onAppear() {
		self.input.bindingValue = Binding<String>(get: {
			self.input.value
		}, set: {
			self.input.value = $0
			self.input.validationRule = FormRules.checkInputIsValid(input: self.input)
		})
		
		self.input.onWrongAttemptSubmit = {
			self.wrongAttempt.toggle()
		}
		
		form.onChangingInput(name: self.input.name, newInput: self.input)
	}
	
    var body: some View {
		
		return (
			VStack(alignment: .leading, spacing: 2.0) {
				if self.input.isPassword {
					SecureField(input.placeholder, text: self.input.bindingValue!)
						.textFieldStyle(CustomTextField(input: self.input, wrongAttempt: self.wrongAttempt))
				}
				else {
					TextField(input.placeholder, text: self.input.bindingValue!)
						.keyboardType(self.input.keyboardType)
						.textFieldStyle(CustomTextField(input: self.input, wrongAttempt: self.wrongAttempt))
				}
		
				Text(self.input.validationRule != nil ? self.input.validationRule!.message : "")
					.foregroundColor(CustomColor.danger)
					.font(.system(size: 12, weight: .medium, design: .rounded))
					.padding(.horizontal, 7)
			}.padding(.horizontal, 7)
		)
		.onAppear{ self.onAppear() }
	}
	
}


struct CustomInputView_Previews: PreviewProvider {
	@State static var form = FormModel.init(inputs: [])
	@State static var input = FormInputModel.init(name: "nome", placeholder: "Nome")

    static var previews: some View {
		CustomInput(
			form: form,
			input: input
		)
		.previewLayout(.fixed(width: 300, height: 100))
    }
}
