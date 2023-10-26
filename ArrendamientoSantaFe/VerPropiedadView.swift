import SwiftUI
import MapKit

struct LocationAnnotation: Identifiable {
    var id = UUID()  // Asegura que LocationAnnotation cumpla con el protocolo Identifiable
    var name: String
    var coordinate: CLLocationCoordinate2D
}

struct VerPropiedadView: View {
    
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 6.165826, longitude: -75.583462), // Coordenadas de San Francisco como ejemplo
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.1)
    )

    @State private var searchText: String = ""

    let locations: [LocationAnnotation] = [
        LocationAnnotation(name: "Ubicación 1", coordinate: CLLocationCoordinate2D(latitude: 6.177465, longitude: -75.586786)),
        LocationAnnotation(name: "Ubicación 2", coordinate: CLLocationCoordinate2D(latitude: 6.231635766011566, longitude: -75.60998664209502)),
    ]

    var body: some View {
        VStack {
                Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width:200).padding(.bottom, 10)
            
            TextField("Escribe una dirección", text: $searchText, onCommit: {
                // Aquí puedes agregar la lógica para convertir la dirección en coordenadas y actualizar la región
                geocodeAddress()
            })
            .padding(10)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(8)
            .padding(.horizontal)

            Map(coordinateRegion: $region, annotationItems: locations) { location in
                MapPin(coordinate: location.coordinate, tint: .blue)
            }
            .ignoresSafeArea()
        }
    }

    func geocodeAddress() {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(searchText) { (placemarks, error) in
            guard let placemarks = placemarks,
                  let location = placemarks.first?.location?.coordinate else {
                print("No location found for \(searchText)")
                return
            }
            region.center = location
        }
    }
}

struct VerPropiedadView_Previews: PreviewProvider {
    
    static var previews: some View {
        VerPropiedadView()
    }
}
#Preview {
    VerPropiedadView()
}

