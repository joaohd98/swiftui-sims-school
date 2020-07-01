//
//  CustomInputView.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct CustomInputView: View {
	@State var textValue: String = "Abc"
	var placeholder: String = ""
	
    var body: some View {
		VStack(alignment: .leading, spacing: 2.0) {
			TextField(placeholder, text: $textValue)
				.padding(.vertical, 8)
				.padding(.horizontal, 10)
				.foregroundColor(CustomColor.inputColor)
				.border(CustomColor.borderInputColor, width: 1)
				.font(.system(size: 13, weight: .medium, design: .rounded))
			
			Text("Digite um email valido")
				.foregroundColor(CustomColor.danger)
				.font(.system(size: 12, weight: .medium, design: .rounded))
				.padding(.horizontal, 7)
		}.padding(.horizontal, 7)
	}
}


struct CustomInputView_Previews: PreviewProvider {
    static var previews: some View {
		CustomInputView(placeholder: "Email").previewLayout(.fixed(width: 300, height: 100))
    }
}
