/*
See LICENSE folder for this sample’s licensing information.

Abstract:
A view for bridging a UIPageViewController.
*/

import SwiftUI

struct SlideHorizontal<Page: View>: View {
    var viewControllers: [UIHostingController<Page>]
	var hasDots: Bool
	@State var currentPage = 0
	
	init(_ views: [Page], hasDots: Bool) {
		self.viewControllers = views.map { UIHostingController(rootView: $0) }
		self.hasDots = hasDots
	}

    var body: some View {
		VStack(alignment: .center, spacing: 5) {
            CustomUIPageViewController(controllers: viewControllers, currentPage: $currentPage)
			if self.hasDots {
				SlideHorizontalDots(numberOfPages: viewControllers.count, currentPage: $currentPage)
			}
        }
    }
}

struct SlideHorizontal_Previews: PreviewProvider {
	static func getExampleView() -> some View {
		ZStack {
			EmptyView()
		}
	}
    static var previews: some View {
		SlideHorizontal([getExampleView(), getExampleView(), getExampleView()], hasDots: false)
            .aspectRatio(3 / 2, contentMode: .fit)
    }
}
