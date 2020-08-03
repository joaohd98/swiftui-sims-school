//
//  TipsService.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

class TipsService {
	static func getTips(
		request: TipsRequest,
		onSucess: @escaping (_ tips: [TipsResponse]) -> Void,
		onError: @escaping () -> Void
	) {
		let db = FirebaseDatabase.db
		let doc = db.collection("tips").document(request.id_class)

		doc.getDocument(source: .server) { (document, error) in
			if let document = document, document.exists, let dictionary = document.data() {
				let tips = dictionary["tips"] as! [[String: Any]]
				
				let group = DispatchGroup()

				var response = tips.parallel.map { TipsResponse(dictionary: $0, group: group) }

				group.notify(queue: .main) {
					let size = response.count
					response = response.enumerated().map {(index, tip) in
						tip.index = index
						tip.mediasIndex = 0
						
						let prev = index - 1 > -1 ? index - 1 : nil
						let next = index + 1 < size ? index + 1 : nil
						tip.indicies.prevTip = prev
						tip.indicies.nextTip = next
						
						return tip
					}
					
					onSucess(response)
				}
			}
				
			else {
				onError()
			}
		}
	}
	
	static func getMedia(
		media: TipsMediasResponse,
		hasPause: Binding<Bool>,
		completion: @escaping ((_ url: URL?, _ image: UIImage?, _ video: VideoView?) -> Void)) {
		let isVideo = media.video != nil
		
		FirebaseDatabase.storage.reference().child((isVideo ? media.video : media.image)!).downloadURL { url, error in
			if error == nil, let url = url {
				if isVideo {
					completion(url, nil, VideoView(videoURL: url, hasToPause: false))
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
