//
//  TabsScreen.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TabsScreen: View {
    var body: some View {
		TabView {
			HomeScreen()
			 .tabItem {
				Image(systemName: "phone.fill")
				Text("First Tab")
			  }
			Text("The content of the second view")
			  .tabItem {
				 Image(systemName: "phone.fill")
				 Text("Second Tab")
			   }
			Text("The content of the third view")
			   .tabItem {
				  Image(systemName: "phone.fill")
				  Text("First Tab")
				}
			Text("The content of the fourth view")
			.tabItem {
			   Image(systemName: "phone.fill")
			   Text("First Tab")
			 }
		}
	}
}

struct TabsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TabsScreen()
    }
}
