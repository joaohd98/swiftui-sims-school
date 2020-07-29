//
//  ScoreScreenModel.swift
//  Sims School
//
//  Created by João Damazio on 28/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

class ScoreScreenModel: ObservableObject {
	var user: UserResponse? = nil
	var firstRun: Bool = true
	@Published var scores: [ScoresResponse] = []
	@Published var scoresStatus: NetworkRequestStatus = .loading
	@Published var actualSemester: Int = 0
	
	func initProps(users: FetchedResults<UserEntity>, scores: FetchedResults<ScoreEntity>) {
		if firstRun {
			self.getUserRequest(users: users)
			self.getScoresRequest(scores: scores)
			firstRun.toggle()
		}
	}
	
	func getUserRequest(users: FetchedResults<UserEntity>) {
		if users.count > 0 {
			self.user = UserResponse(user: users[0])
		}
	}
	
	func getScoresRequest(scores: FetchedResults<ScoreEntity>) {
		DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
			if let id = self.user?.uid {
				ScoresService.getScores(
					request: ScoresRequest(id: id),
					onSucess: { scores in
						self.scores = scores
						self.actualSemester = scores.count
						self.scoresStatus = .success
				},
					onError: {
						self.scoresStatus = .failed
				})
			}
		}		
	}
}
