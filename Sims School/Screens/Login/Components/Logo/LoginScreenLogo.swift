//
//  LoginScreenLogo.swift
//  Sims School
//
//  Created by João Damazio on 10/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct LoginScreenLogo: View {
    var body: some View {
        CustomImages
		.logo
		.resizable()
		.frame(width: 150, height: 150)
		.padding(.bottom, 25)
    }
}

struct LoginScreenLogo_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreenLogo()
    }
}
