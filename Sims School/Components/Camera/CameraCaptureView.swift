//
//  CameraCaptureView.swift
//  Sims School
//
//  Created by João Damazio on 27/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI

struct CameraCaptureView: UIViewControllerRepresentable {
	@Binding var showCameraView: Bool
	@Binding var pickedImage: Image
	@Binding var sourceType: UIImagePickerController.SourceType

	func makeUIViewController(context: UIViewControllerRepresentableContext<CameraCaptureView>) -> UIImagePickerController {
		let cameraViewController = UIImagePickerController()
		cameraViewController.delegate = context.coordinator
		cameraViewController.sourceType = sourceType
		cameraViewController.allowsEditing = true
		return cameraViewController
	}
	
	func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<CameraCaptureView>) {
		uiViewController.sourceType = sourceType
	}
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
		var parent: CameraCaptureView
		
		init(_ cameraView: CameraCaptureView) {
			self.parent = cameraView
		}
		
		func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
			let uiImage = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
			parent.pickedImage = Image(uiImage: uiImage)
			parent.showCameraView = false
		}
		
		func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
			parent.showCameraView = false
		}
	}
}

struct CameraCaptureView_Previews: PreviewProvider {
	@State static var isShown: Bool = true
	@State static var image: Image = Image("")
	@State static var sourceType: UIImagePickerController.SourceType = .photoLibrary

	static var previews: some View {
		CameraCaptureView(showCameraView: $isShown, pickedImage: $image, sourceType: $sourceType)
	}
}
