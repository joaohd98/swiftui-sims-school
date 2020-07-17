//
//  WebView.swift
//  Sims School
//
//  Created by João Damazio on 16/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import SwiftUI
import SafariServices

struct SafariView: UIViewControllerRepresentable {
    let url: URL

    func makeUIViewController(context: UIViewControllerRepresentableContext<SafariView>) -> SFSafariViewController {
		let safari = SFSafariViewController(url: url)
		safari.modalPresentationStyle = .fullScreen
		
		safari.delegate = context.coordinator
		
		return safari
    }

    func updateUIViewController(_ uiViewController: SFSafariViewController, context: UIViewControllerRepresentableContext<SafariView>) {

    }
	
	func makeCoordinator() -> Coordinator {
		Coordinator(self)
	}
	
	class Coordinator: NSObject, SFSafariViewControllerDelegate {
		var parent: SafariView
		
		init(_ safariVC: SafariView) {
			self.parent = safariVC
		}
		
	}

}
struct WebView_Previews: PreviewProvider {
	static var previews: some View {
		SafariView(url: URL(string: "google.com.br")!)
	}
}
