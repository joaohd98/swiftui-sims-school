import UIKit
import SwiftUI
import Combine

extension UIResponder {
	static var currentFirstResponder: UIResponder? {
		_currentFirstResponder = nil
		UIApplication.shared.sendAction(#selector(UIResponder.findFirstResponder(_:)), to: nil, from: nil, for: nil)
		return _currentFirstResponder
	}
	
	private static weak var _currentFirstResponder: UIResponder?
	
	@objc private func findFirstResponder(_ sender: Any) {
		UIResponder._currentFirstResponder = self
	}
	
	var globalFrame: CGRect? {
		guard let view = self as? UIView else { return nil }
		return view.superview?.convert(view.frame, to: nil)
	}
}

extension Publishers {
	// 1.
	static var keyboardHeight: AnyPublisher<CGFloat, Never> {
		// 2.
		let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
			.map { $0.keyboardHeight }
		
		let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
			.map { _ in CGFloat(0) }
		
		// 3.
		return MergeMany(willShow, willHide)
			.eraseToAnyPublisher()
	}
}

extension Notification {
	var keyboardHeight: CGFloat {
		return (userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect)?.height ?? 0
	}
}

struct KeyboardAdaptive: ViewModifier {
	@State private var bottomPadding: CGFloat = 0
	
	func body(content: Content) -> some View {
		// 1.
		GeometryReader { geometry in
			content
				.padding(.bottom, self.bottomPadding)
				// 2.
				.onReceive(Publishers.keyboardHeight) { keyboardHeight in
					// 3.
					let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
					// 4.
					let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
					// 5.
					self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
			}
				// 6.
				.animation(.easeOut(duration: 0.16))
		}
	}
}

extension View {
	func keyboardAdaptive() -> some View {
		ModifiedContent(content: self, modifier: KeyboardAdaptive())
	}
}
