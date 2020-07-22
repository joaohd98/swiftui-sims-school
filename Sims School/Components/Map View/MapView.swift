import MapKit
import SwiftUI

struct MapView: UIViewRepresentable {
	var coordinate: CLLocationCoordinate2D
	
	func makeUIView(context: Context) -> MKMapView {
		let mapView = MKMapView(frame: .zero)
		
		let annotation = MKPointAnnotation()
		annotation.coordinate = self.coordinate
		annotation.title = "Sims School"
		annotation.subtitle = "Fictional University"
		mapView.addAnnotation(annotation)
		
		let span = MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02)
		let region = MKCoordinateRegion(center: coordinate, span: span)
		mapView.setRegion(region, animated: true)
		
		return mapView
	}
	
	func updateUIView(_ uiView: MKMapView, context: Context) {

	}

}

struct MapView_Previews: PreviewProvider {
    @State static var region = CLLocationCoordinate2D(latitude: 51.507222, longitude: -0.1275)

	static var previews: some View {
		MapView(coordinate: region)
	}
}
