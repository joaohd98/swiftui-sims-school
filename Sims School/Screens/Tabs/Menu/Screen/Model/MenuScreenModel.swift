//
//  MenuScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 21/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import SwiftUI

class MenuScreenModel: ObservableObject {
	@Published var options: [(text: String, image: Image)] = [
		(text: "Home", image: Image(systemName: "house")),
		(text: "Score", image: Image(systemName: "lightbulb")),
		(text: "Classes", image: Image(systemName: "folder")),
		(text: "Tips", image: Image(systemName: "tray.full")),
		(text: "Location", image: Image(systemName: "location")),
		(text: "Share", image: Image(systemName: "arrowshape.turn.up.right")),
	]
}
