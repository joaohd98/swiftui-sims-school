//
//  VideoCache.swift
//  Sims School
//
//  Created by João Damazio on 01/08/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation

class VideoCache: NSObject , NSDiscardableContent {

    public var video: VideoView!

    func beginContentAccess() -> Bool {
        return true
    }

    func endContentAccess() {

    }

    func discardContentIfPossible() {

    }

    func isContentDiscarded() -> Bool {
        return false
    }
}
