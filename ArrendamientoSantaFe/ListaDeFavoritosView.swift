import SwiftUI

struct Propiedad: Identifiable {
    let id = UUID()
    let imagen: Image
    let ubicacion: String
    let tipo: String
    let precio: String
    let link: String
}

struct PropiedadFavorita: Identifiable {
    let id = UUID()
    let propiedad: Propiedad
}

struct TarjetaDePropiedadView: View {
    var propiedad: Propiedad
    var isInFavoritesView: Bool
    @Binding var propiedadesFavoritas: [PropiedadFavorita]
    @Binding var propiedadesAgregadas: Set<UUID> // Conjunto de identificadores de propiedades agregadas a favoritos

    var body: some View {
        VStack(alignment: .leading) {
            propiedad.imagen
                .resizable()
                .aspectRatio(contentMode: .fit)
            
            Text(propiedad.ubicacion).font(.headline)
            Text(propiedad.tipo).font(.subheadline)
            Text(propiedad.precio).font(.title)
            
            if !isInFavoritesView && !propiedadesAgregadas.contains(propiedad.id) {
                Button(action: {
                    // Marcar la propiedad como agregada a favoritos
                    propiedadesAgregadas.insert(propiedad.id)
                    // Agregar la propiedad actual a favoritos
                    propiedadesFavoritas.append(PropiedadFavorita(propiedad: propiedad))
                }) {
                    Image(systemName: "plus.circle.fill")
                        .foregroundColor(.blue)
                        .font(.title)
                }
            } else {
                Link("Ver más detalles", destination: URL(string: propiedad.link)!)
                    .font(.title2)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}

struct ListaDeFavoritosView: View {
    let propiedades: [Propiedad] = [
        Propiedad(imagen: Image("propiedad1"), ubicacion: "Conquistadores", tipo: "Apartaestudio", precio: "$850.000", link: "https://www.arrendamientossantafe.com/propiedad/A11016/"),
        Propiedad(imagen: Image("propiedad2"), ubicacion: "Castellana", tipo: "Casa", precio: "$2.300.000", link: "https://www.arrendamientossantafe.com/propiedad/A11522/"),
        Propiedad(imagen: Image("propiedad3"), ubicacion: "Floresta", tipo: "Casa", precio: "$1.800.000", link: "https://www.arrendamientossantafe.com/propiedad/A121/"),
        Propiedad(imagen: Image("propiedad4"), ubicacion: "Florida Nueva", tipo: "Casa", precio: "$6.0000.000", link: "https://www.arrendamientossantafe.com/propiedad/A12617/"),
        Propiedad(imagen: Image("propiedad5"), ubicacion: "Laureles", tipo: "Apartamento", precio: "$3.000.000", link: "https://www.arrendamientossantafe.com/propiedad/A14375/")
    ]
    @State private var propiedadesFavoritas: [PropiedadFavorita] = []
    @State private var propiedadesAgregadas: Set<UUID> = Set()

    var body: some View {
        NavigationView {
            List(propiedades) { propiedad in
                TarjetaDePropiedadView(
                    propiedad: propiedad,
                    isInFavoritesView: false,
                    propiedadesFavoritas: $propiedadesFavoritas,
                    propiedadesAgregadas: $propiedadesAgregadas
                )
            }
            .navigationTitle("Propiedades")
            .navigationBarItems(trailing:
                NavigationLink(destination: FavoritosView(propiedadesFavoritas: $propiedadesFavoritas)) {
                    Text("Ver favoritos")
                }
            )
        }
    }
}

struct FavoritosView: View {
    @Binding var propiedadesFavoritas: [PropiedadFavorita]

    var body: some View {
        NavigationView {
            List(propiedadesFavoritas) { propiedadFavorita in
                TarjetaDePropiedadView(propiedad: propiedadFavorita.propiedad, isInFavoritesView: true, propiedadesFavoritas: $propiedadesFavoritas, propiedadesAgregadas: .constant(Set()))
            }
            .navigationTitle("Favoritos")
        }
    }
}

struct ListaDeFavoritosView_Previews: PreviewProvider {
    static var previews: some View {
        ListaDeFavoritosView()
    }
}
