//
//  TipsScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import CoreData
import SwiftUI

class TipsScreenModel: ObservableObject {
	var user: UserResponse? = nil
	var firstRun: Bool = true
	@Published var showFullScreen: Bool = false
	@Published var tipsStatus: NetworkRequestStatus = .loading
	@Published var tips: [TipsResponse] = []
	@Published var fullScreenIndex: (tips: Int, medias: Int) = (tips: 0, medias: 0)

	func initProps(users: FetchedResults<UserEntity>, tips: FetchedResults<TipsEntity>) {
		if firstRun {
			self.getUserRequest(users: users)
			self.getTipsRequest(tips: tips)
			firstRun.toggle()
		}
	}
	
	func getUserRequest(users: FetchedResults<UserEntity>) {
		if users.count > 0 {
			self.user = UserResponse(user: users[0])
		}
	}
	
	func getTipsRequest(tips: FetchedResults<TipsEntity>) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			if let id_class = self.user?.id_class {
				TipsService.getTips(
					request: TipsRequest(id_class: id_class),
					onSucess: { tips in
						self.tips = tips
						self.tipsStatus = .success
						print("tips", tips)
						print("tips", tips[0].name)
						print("tips", tips[0].medias)

					},
					onError: {
						self.tipsStatus = .failed
					})
			}
		}
	}

}
 
