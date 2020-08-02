//
//  TipsScreen.swift
//  Sims School
//
//  Created by João Damazio on 20/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct TipsScreen: View {
	@FetchRequest(entity: UserEntity.entity(), sortDescriptors: []) var users: FetchedResults<UserEntity>
	@FetchRequest(entity: TipsEntity.entity(), sortDescriptors: []) var tips: FetchedResults<TipsEntity>
	@ObservedObject var props: TipsScreenModel
	
	func viewDidLoad() {
		self.props.initProps(users: self.users, tips: self.tips)
	}
	
	var errorView: some View {
		TryAgainView(
			text: "There was an error when trying to get the tips.",
			onTryAgain: {
				self.props.tipsStatus = .loading
				DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
					self.props.getTipsRequest(tips: self.tips)
				}
			}
		)
		.padding(.horizontal)
	}
	
	var defaultView: some View {
		TipsScreenList(
			tips: self.$props.tips,
			status: self.$props.tipsStatus,
			fullScreenIndex: self.$props.fullScreenIndex,
			showFullScreen: self.$props.showFullScreen
		)
		.disabled(self.props.tipsStatus == .loading)
		.sheet(isPresented: self.$props.showFullScreen) {
			TipsFullScreen(
				tips: self.props.tips,
				tipIndex: self.props.fullScreenIndex
			)
		}
	}
	
	var body: some View {
		CustomContainerSignIn {
			Group {
				if self.props.tipsStatus == .failed {
					self.errorView
				}
				else {
					self.defaultView
				}
			}
			.onAppear { self.viewDidLoad() }
			.navigationBarTitle("Tips")
		}
		
	}
}

struct TipsScreen_Previews: PreviewProvider {
	
	static var previews: some View {
		TipsScreen(props: TipsScreenModel())
	}
}
