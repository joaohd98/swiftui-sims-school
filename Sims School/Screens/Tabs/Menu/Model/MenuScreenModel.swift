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
	@Published var options: [(text: String, image: Image, destination: String)] = [
		(text: "Home", image: Image(systemName: "house"), destination: "MArio"),
		(text: "Score", image: Image(systemName: "lightbulb"), destination: "MArio"),
		(text: "Classes", image: Image(systemName: "folder"), destination: "MArio"),
		(text: "Tips", image: Image(systemName: "tray.full"), destination: "MArio"),
		(text: "Location", image: Image(systemName: "location"), destination: "MArio"),
		(text: "Share", image: Image(systemName: "arrowshape.turn.up.right"), destination: "MArio"),
	]
}
