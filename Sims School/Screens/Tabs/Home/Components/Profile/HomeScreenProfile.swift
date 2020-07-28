//
//  HomeScreenProfile.swift
//  Sims School
//
//  Created by João Damazio on 14/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct HomeScreenProfile: View {
	@Environment(\.managedObjectContext) var managedObjectContext
	@State var showActionSheetCamera: Bool = false
	@State var showCapturingCamera: Bool = false
	@State var changingPicture: Bool = false
	@State var showAlertCamera: Bool = false
	@State var sourceType: UIImagePickerController.SourceType = .photoLibrary
	var userEntity: UserEntity
	
	func takePictureProfile(type: UIImagePickerController.SourceType) {
		self.sourceType = type
		self.showCapturingCamera.toggle()
	}
	
	var body: some View {
		VStack(alignment: .leading, spacing: 5) {
			URLImage(url: userEntity.cover_picture, configuration: { $0.resizable() })
				.frame(
					width: UIScreen.screenWidth,
					height: 100
			)
			VStack(alignment: .leading, spacing: 5) {
				ZStack(alignment: .leading) {
					URLImage(url: self.changingPicture ? nil : userEntity.profile_picture, configuration: { $0.resizable() })
						.frame(width: 75, height: 75)
						.onTapGesture { self.showActionSheetCamera.toggle() }
						.actionSheet(isPresented: $showActionSheetCamera) {
							ActionSheet(title: Text(""), message: Text("Change profile picture"), buttons: [
								.default(Text("Camera")) { self.takePictureProfile(type: .camera) },
								.default(Text("Library")) { self.takePictureProfile(type: .photoLibrary)  },
								.cancel()
							])
						}
						.sheet(isPresented: $showCapturingCamera) {
						CameraCaptureView(
							showCameraView: self.$showCapturingCamera,
							sourceType: self.$sourceType,
							onTakePicture: { data in
								self.changingPicture.toggle()
								
								let user = UserResponse(user: self.userEntity)
								
								user.setPicturePhoto(pictureData: data) { error in
									
									if error != nil {
										self.showAlertCamera.toggle()
										return
									}
								
									user.updateContext(self.userEntity, managedObjectContext: self.managedObjectContext)
									self.changingPicture.toggle()
								}
						}
						)
					}
					.alert(isPresented: self.$showAlertCamera) {
						Alert(
							title: Text("There was an error when changing profile picture"),
							message: Text("Try again later"),
							dismissButton: .default(Text("OK"))
						)
					}
				}
				.padding(.all, 3)
				.background(Color(UIColor.init { (trait) -> UIColor in
					return trait.userInterfaceStyle == .dark ? .white : .black
				}))
				VStack(alignment: .leading, spacing: 5) {
					Text(self.userEntity.name)
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 16, weight: .bold))
					
					HStack {
						Text("RM:")
							.foregroundColor(Color(CustomColor.gray))
							.font(.system(size: 16, weight: .bold))
						
						Text(self.userEntity.rm)
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
					
					Text(self.userEntity.actual_class)
						.foregroundColor(Color(CustomColor.gray))
						.font(.system(size: 14, weight: .semibold))
				}
				
				Text(self.userEntity.course)
					.foregroundColor(Color(CustomColor.gray))
					.font(.system(size: 16, weight: .bold))
			}
			.padding()
			.padding(.top, -50)
		}
	}
}

struct HomeScreenProfile_Previews: PreviewProvider {
	@State static var user: UserEntity = UserEntity()

	static var previews: some View {
		HomeScreenProfile(userEntity: self.user)
			.previewLayout(.fixed(width: UIScreen.screenWidth, height: 300))
	}
}
