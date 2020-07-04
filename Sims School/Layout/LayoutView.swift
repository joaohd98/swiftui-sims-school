//
//  Layout.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct LayoutView: View {
    var body: some View {
		NavigationView {
			LoginScreen()
		}
    }
}

struct Layout_Previews: PreviewProvider {
    static var previews: some View {
        LayoutView()
    }
}
