//
//  TipsFullScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import Foundation
import AVFoundation
import UIKit

class TipsFullScreenModel: ObservableObject {
	@Published var tips: [TipsResponse]
	@Published var index: Int
	@Published var goPage: Int?
	@Published var isSliding: Bool
	
	init(tips: [TipsResponse], index: Int) {
		self.tips = tips
		self.index = index
		self.goPage = nil
		self.isSliding = false
	}
}

