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

class TipsResponse: ObservableObject {
	@Published var name: String
	@Published var medias: [TipsMediasResponse]
	@Published var thumbnail: UIImage!
	
	init() {
		name = ""
		medias = []
	}
}

extension TipsResponse  {
	convenience init(dictionary: [String: Any]) {
		self.init()
		
		self.name = dictionary["name"] as! String
		let medias = dictionary["medias"] as! [[String: Any]]
		
		medias.forEach { media in
			self.medias.append(TipsMediasResponse(dictionary: media))
		}
		
		let media = self.medias.randomElement()!		
	}
	

	private func getThumbnailFromImage(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
		DispatchQueue.global().async {
			let asset = AVAsset(url: url)
			let avAssetImageGenerator = AVAssetImageGenerator(asset: asset)
			avAssetImageGenerator.appliesPreferredTrackTransform = true
			let thumnailTime = CMTimeMake(value: 2, timescale: 1)
			do {
				let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil)
				let thumbNailImage = UIImage(cgImage: cgThumbImage)
				DispatchQueue.main.async {
					completion(thumbNailImage)
				}
			} catch {
				DispatchQueue.main.async {
					completion(nil)
				}
			}
		}
	}
	
	private func getThumbnailImageFromVideoUrl(url: URL, completion: @escaping ((_ image: UIImage?)->Void)) {
		DispatchQueue.global().async { //1
			let asset = AVAsset(url: url) //2
			let avAssetImageGenerator = AVAssetImageGenerator(asset: asset) //3
			avAssetImageGenerator.appliesPreferredTrackTransform = true //4
			let thumnailTime = CMTimeMake(value: 2, timescale: 1) //5
			do {
				let cgThumbImage = try avAssetImageGenerator.copyCGImage(at: thumnailTime, actualTime: nil) //6
				let thumbNailImage = UIImage(cgImage: cgThumbImage) //7
				DispatchQueue.main.async { //8
					completion(thumbNailImage) //9
				}
			} catch {
				DispatchQueue.main.async {
					completion(nil) //11
				}
			}
		}
	}
}
