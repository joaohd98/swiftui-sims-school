//
//  Colors.swift
//  swiftui-escola
//
//  Created by João Damazio on 01/07/20.
//  Copyright © 2020 João Damazio. All rights reserved.
//

import Foundation
import UIKit
import SwiftUI

@frozen public struct CustomColor {
	static let inputColor: Color = Color.init(#colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1));
	static let borderInputColor: Color = Color.init(#colorLiteral(red: 0.8784313725, green: 0.8784313725, blue: 0.8784313725, alpha: 1))
	static let danger: Color = Color.init(#colorLiteral(red: 0.862745098, green: 0.2078431373, blue: 0.2705882353, alpha: 1))
	static let success: Color = Color.init(#colorLiteral(red: 0.1568627451, green: 0.6549019608, blue: 0.2705882353, alpha: 1))
	static let warning: Color = Color.init(#colorLiteral(red: 1, green: 0.7568627451, blue: 0.02745098039, alpha: 1))
	static let link: Color = Color.init(#colorLiteral(red: 0.02352941176, green: 0.2705882353, blue: 0.6784313725, alpha: 1))
	static let white: Color = Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
	static let backgroundLoading: Color = Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
}
