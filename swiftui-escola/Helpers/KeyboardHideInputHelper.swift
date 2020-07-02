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
	static var keyboardHeight: AnyPublisher<CGFloat, Never> {
		let willShow = NotificationCenter.default.publisher(for: UIApplication.keyboardWillShowNotification)
			.map { $0.keyboardHeight + 75 }
		
		let willHide = NotificationCenter.default.publisher(for: UIApplication.keyboardWillHideNotification)
			.map { _ in CGFloat(0) }
		
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
		GeometryReader { geometry in
			content
				.padding(.bottom, self.bottomPadding)
				.onReceive(Publishers.keyboardHeight) { keyboardHeight in
					let keyboardTop = geometry.frame(in: .global).height - keyboardHeight
					let focusedTextInputBottom = UIResponder.currentFirstResponder?.globalFrame?.maxY ?? 0
					self.bottomPadding = max(0, focusedTextInputBottom - keyboardTop - geometry.safeAreaInsets.bottom)
			}
			.animation(.easeOut(duration: 0.16))
		}
	}
}

extension View {
	func keyboardAdaptive() -> some View {
		ModifiedContent(content: self, modifier: KeyboardAdaptive())
	}
}
