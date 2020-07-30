//
//  UrlImage.swift
//  Sims School
//
//  Created by João Damazio on 30/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit

extension URLSession {
	static var cacheIMG = NSCache<NSString, ImageCache>()
	
	func downloadImageAndCache(url: URL?, completion: @escaping (_ image: UIImage?) -> Void) {
		guard let url = url else {
			completion(nil)
			return
		}
		
		URLSession.shared.dataTask(
			with: url,
			completionHandler: { (data, response, error) in
				DispatchQueue.main.async {
					if data != nil, let image = UIImage(data: data!) {
						self.setCacheIMG(image, url: url)
						completion(image)
					}
						
					else {
						completion(nil)
					}
				}
			}
		).resume()
	}

	func getCacheIMG(url: URL?) -> ImageCache? {
		if let url = url  {
			return Self.cacheIMG.object(forKey: url.absoluteString as NSString)
		}
		
		return nil
	}
	
	func setCacheIMG(_ image: UIImage, url: URL?) {
		if let url = url  {
			let cacheImage = ImageCache()
			cacheImage.image = image
			
			Self.cacheIMG.setObject(cacheImage, forKey: url.absoluteString as NSString)
		}
	}
	

}
