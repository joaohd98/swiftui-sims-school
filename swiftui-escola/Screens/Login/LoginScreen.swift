//
//  LoginScreen.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct LoginScreen: View {
    var body: some View {
		VStack(alignment: .center, spacing: 30) {
			CustomImages.logo.resizable().frame(width: 150, height: 150)
			CustomInputView(textValue: "", placeholder: "Email")
			CustomInputView(textValue: "", placeholder: "Senha")
			Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
				Text("Fazer login")
					.padding(.vertical, 10)
					.padding(.horizontal, 20)
					.foregroundColor(CustomColor.white)
					.background(CustomColor.link)
					.cornerRadius(15)


			}
		}.padding()
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
