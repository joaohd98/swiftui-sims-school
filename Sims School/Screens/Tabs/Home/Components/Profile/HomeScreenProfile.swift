//
//  HomeScreenProfile.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenProfile: View {
	@Environment(\.imageCache) var cache: ImageCache
	@State var showActionSheetCamera: Bool = false
	@State var showCapturingCamera: Bool = false
	@State var image: Image = Image("")
	@State var sourceType: UIImagePickerController.SourceType = .photoLibrary
	
	var user: UserEntity?

	func takePictureProfile(type: UIImagePickerController.SourceType) {
		self.sourceType = type
		self.showCapturingCamera.toggle()
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			URLImage(url: user?.cover_picture, cache: cache, configuration: { $0.resizable() })
				.frame(
					width: UIScreen.screenWidth,
					height: 100
			)
			VStack(alignment: .leading, spacing: 5) {
				ZStack(alignment: .leading) {
					URLImage(url: user?.profile_picture, cache: cache, configuration: { $0.resizable() })
						.frame(
							width: 75,
							height: 75
						)
						.onTapGesture { self.showActionSheetCamera.toggle() }
						.actionSheet(isPresented: $showActionSheetCamera) {
							ActionSheet(title: Text(""), message: Text("Mudar foto de perfil"), buttons: [
								.default(Text("Camera")) { self.takePictureProfile(type: .camera) },
								.default(Text("Library")) { self.takePictureProfile(type: .photoLibrary)  },
								.cancel()
							])
						}
						.sheet(isPresented: $showCapturingCamera) {
							CameraCaptureView(
								showCameraView: self.$showCapturingCamera,
								pickedImage: self.$image,
								sourceType: self.$sourceType
							)
						}
				}
				.padding(.all, 3)
				.background(Color(UIColor.init { (trait) -> UIColor in
					return trait.userInterfaceStyle == .dark ? .white : .black
				}))
				VStack(alignment: .leading, spacing: 5) {
					Text(self.user?.name ?? "")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))
					
					HStack {
						Text("RM:")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 16, weight: .bold))
						
						Text(self.user?.rm ?? "")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 14, weight: .semibold))
						
					}
				}
				.padding(.leading, 95)
				.padding(.top, -52)
				
				HStack(alignment: .firstTextBaseline) {
					Text("Turma:")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))
					
					Text(self.user?.actual_class ?? "")
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 14, weight: .semibold))
				}
				
				Text(self.user?.course ?? "")
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 16, weight: .bold))
			}
			.padding()
			.padding(.top, -50)
		}
	}
}

struct HomeScreenProfile_Previews: PreviewProvider {
	@State static var user: UserEntity? = nil
	
	static var previews: some View {
		HomeScreenProfile(user: self.user)
			.previewLayout(.fixed(width: UIScreen.screenWidth, height: 300))
	}
}
