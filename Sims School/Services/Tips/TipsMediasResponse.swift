//
//  TipsMediasResponse.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI
import AVFoundation

class TipsMediasResponse: ObservableObject {
	@Published var url: URL!
	@Published var image: String!
	@Published var video: String!
	
	func getMedia(completion: @escaping ((_ url: URL?, _ image: UIImage?, _ video: VideoView?) -> Void)) {
		let isVideo = self.video != nil
		
		DispatchQueue.global().async {
			FirebaseDatabase.storage.reference().child(isVideo ? self.video : self.image).downloadURL { url, error in
				if error == nil, let url = url {
					if isVideo {
						completion(url, nil, VideoView(videoURL: url))
					}
						
					else {
						URLSession.shared.downloadImageAndCache(url: url) { image in
							if let image = image {
								completion(url, image , nil)
							}
							else {
								completion(url, nil, nil)
							}
						}
					}
				}
				else {
					completion(nil, nil, nil)
				}
			}
		}
	}
	
}

extension TipsMediasResponse  {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.url = URL(string: dictionary["url"] as! String)!
		self.image =  dictionary["image"] as? String ?? nil
		self.video =  dictionary["video"] as? String ?? nil
	}
}
