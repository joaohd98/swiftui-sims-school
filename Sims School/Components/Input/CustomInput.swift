//
//  CustomInputView.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

fileprivate struct ShakeEffect: GeometryEffect {
    func effectValue(size: CGSize) -> ProjectionTransform {
        return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
    }
    
    init(shakes: Int) {
        position = CGFloat(shakes)
    }
    
    var position: CGFloat
    var animatableData: CGFloat {
        get { position }
        set { position = newValue }
    }
}

struct CustomInput: View {
	@ObservedObject var input: FormInputModel

    var body: some View {
		let color = self.input.getColor()
		let message = color == CustomColor.danger ||  color == CustomColor.warning ? self.input.validationRule!.message : ""
				
		return (
			VStack(alignment: .leading, spacing: 2.0) {
				UIInput(input: self.input)
					.frame(height: 40, alignment: .center)
			
				Text(message)
					.foregroundColor(Color(color))
					.font(.system(size: 12, weight: .medium, design: .rounded))
					.padding(.horizontal, 7)
			}
			.padding(.horizontal, 7)
			.modifier(ShakeEffect(shakes: self.input.howManyAttempts * 2))
			.animation(Animation.linear)
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
