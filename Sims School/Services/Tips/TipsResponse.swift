//
//  TipsResponse.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

private enum TypeMedia {
	case image
	case video
}

class TipsResponse: ObservableObject {
	@Published var name: String
	@Published var medias: [TipsMediasResponse]
	@Published var thumbnail: UIImage
	@Published var indicies: (prevTip: Int?, nextTip: Int?)
	@Published var test: Bool = false

	init() {
		name = ""
		medias = []
		thumbnail = UIImage()
		indicies = (prevTip: nil, nextTip: nil)
	}
}

extension TipsResponse  {
	convenience init(dictionary: [String: Any], group: DispatchGroup) {
		self.init()
		
		self.name = dictionary["name"] as! String
		let medias = dictionary["medias"] as! [[String: Any]]
		
		medias.forEach { media in
			self.medias.append(TipsMediasResponse(dictionary: media))
		}
		
//		let media = self.medias.randomElement()!
//		
//		group.enter()
//		self.getThumbnail(media: media) { image in
//			if let image = image {
//				self.thumbnail = image
//			}
//			group.leave()
//		}
		
	}
	
	func getThumbnail(media: TipsMediasResponse, completion: @escaping ((_ image: UIImage?)->Void)) {
		let stringToUrl: (_ value: String, _ type: TypeMedia) -> Void = { (value, type)  in
			FirebaseDatabase.storage.reference().child(value).downloadURL { url, error in
				if error == nil, let url = url {
					if type == .image {
						self.getThumbnailFromImage(url: url, completion: completion)
					}
					if type == .video {
						self.getThumbnailFromVideo(url: url, completion: completion)
					}
				}
				else {
					completion(nil)
				}
			}
		}
		
		if let cache = URLSession.shared.getCacheIMG(url: media.url) {
			completion(cache.image)
		}
			
		else if let image = media.image {
			stringToUrl(image, .image)
		}
			
		else if let video = media.video {
			stringToUrl(video, .video)
		}
			
		else {
			completion(nil)
		}
	}
	
	private func getThumbnailFromVideo(url: URL, completion: @escaping ((_ image: UIImage?) -> Void)) {
		DispatchQueue.global().async {
			let asset = AVAsset(url: url)
			let imageGenerator = AVAssetImageGenerator(asset: asset)
			imageGenerator.appliesPreferredTrackTransform = true

			let time = CMTimeMakeWithSeconds(Float64(15), preferredTimescale: 100)

			do {
				let thumbnailImage = try imageGenerator.copyCGImage(at: time , actualTime: nil)
				let image = UIImage(cgImage: thumbnailImage)
				
				URLSession.shared.setCacheIMG(image, url: url)
				
				DispatchQueue.main.async {
					completion(image)
				}
				
			} catch {
				DispatchQueue.main.async {
					completion(nil)
				}
			}
		}
	}
	
	private func getThumbnailFromImage(url: URL, completion: @escaping ((_ image: UIImage?) -> Void)) {
		DispatchQueue.global().async {
			URLSession.shared.downloadImageAndCache(url: url) { image in
				completion(image)
			}
		}
	}
}
