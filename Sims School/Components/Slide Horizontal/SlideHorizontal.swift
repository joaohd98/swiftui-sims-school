/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct SlideHorizontal<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
	var hasDots: Bool
	@Binding var currentPage: Int
	var isInModal: Bool
	
	init(_ views: [Page], hasDots: Bool, currentPage: Binding<Int>, isInModal: Bool = false) {
		self.viewControllers = views.map { UIHostingController(rootView: $0) }
		self.hasDots = hasDots
		self._currentPage = currentPage
		self.isInModal = isInModal
	}

    var body: some View {
		VStack(alignment: .center, spacing: 0) {
			CustomUIPageViewController(controllers: viewControllers, currentPage: $currentPage, isInModal: isInModal)
			if self.hasDots {
				SlideHorizontalDots(numberOfPages: viewControllers.count, currentPage: $currentPage)
			}
        }
    }
}

struct SlideHorizontal_Previews: PreviewProvider {
	@State static var currentPage: Int = 0
	static func getExampleView() -> some View {
		ZStack {
			EmptyView()
		}
	}

    static var previews: some View {
		SlideHorizontal([getExampleView(), getExampleView(), getExampleView()], hasDots: false, currentPage: $currentPage)
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}
