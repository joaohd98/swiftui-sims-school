//
//  ConnectedView.swift
//  Sims School
//
//  Created by João Damazio on 13/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import FirebaseAuth

class AllViewModel: ObservableObject {
	@Published var isLoading: Bool = false
	@Published var hasError: Bool = false
	@Published var errorCode: AuthErrorCode? = nil
	@Published var hasInternetConnection = true
}
