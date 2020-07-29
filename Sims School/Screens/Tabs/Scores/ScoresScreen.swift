//
//  ScoresScreen.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct ScoresScreen: View {
	@FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var users: FetchedResults<UserEntity>
	@FetchRequest(entity: ScoreEntity.entity(), sortDescriptors: []) var scores: FetchedResults<ScoreEntity>
	@ObservedObject var props: ScoreScreenModel
	
	func viewDidLoad() {
		props.initProps(users: self.users, scores: self.scores)
	}
	
	var errorView: some View {
		TryAgainView(
			text: "There was an error when trying to get the scores.",
			onTryAgain: {
				self.props.scoresStatus = .loading
				
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.props.getScoresRequest(scores: self.scores)
				}
			}
		)
		.padding(.horizontal)
	}
	
	var view: some View {
		ScrollView(showsIndicators: false) {
			ScoresScreenSemesters(
				scores: self.$props.scores,
				status: self.$props.scoresStatus,
				actualSemester: self.$props.actualSemester
			)
			ScoresScreenCardScore(
				score: self.props.scores.count > 0 ? self.props.scores[self.props.actualSemester - 1] : nil,
				status: self.$props.scoresStatus
			)
			.padding(.horizontal)
		}
		.disabled(self.props.scoresStatus == .loading)
		.onAppear(perform: self.viewDidLoad)
	}

    var body: some View {
		CustomContainerSignIn {
			Group {
				if self.props.scoresStatus == .failed {
					self.errorView

				}
				else {
					self.view

				}
			}
			.navigationBarTitle("Score")
		}
    }
}

struct ScoresScreen_Previews: PreviewProvider {
	static let props = ScoreScreenModel()
	
    static var previews: some View {
		ScoresScreen(props: self.props)
    }
}
