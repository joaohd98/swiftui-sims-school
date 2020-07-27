//
//  NetworkRequestStatus.swift
//  Sims School
//
//  Created by João Damazio on 27/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

enum NetworkRequestStatus {
	case success
	case failed
	case loading
	case noInternetConnection
	case usingLocalData
}
