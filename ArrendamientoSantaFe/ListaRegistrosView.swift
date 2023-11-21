import SwiftUI
import UIKit

// Asegúrate de que esta estructura refleje tu modelo de datos
struct InformacionReserva: Identifiable, Codable {
    var id = UUID()
    var nombreApellido: String
    var telefono: String
    var apartamentoSeleccionado: String
    var metodoPagoSeleccionado: String
    var cantidadHabitaciones: Int
}

// Esta vista envuelve UIActivityViewController para su uso en SwiftUI
struct ShareSheet: UIViewControllerRepresentable {
    var itemsToShare: [Any]
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<ShareSheet>) -> UIActivityViewController {
        return UIActivityViewController(activityItems: itemsToShare, applicationActivities: nil)
    }
    
    func updateUIViewController(_ uiViewController: UIActivityViewController, context: UIViewControllerRepresentableContext<ShareSheet>) {}
}

// Vista principal que muestra las reservas y permite compartirlas
struct ListaRegistrosView: View {
    @State private var reservas: [InformacionReserva] = []
    @State private var showShareSheet = false

    var body: some View {
        List {
            ForEach(reservas) { reserva in
                VStack(alignment: .leading) {
                    Text("Nombre y Apellido: \(reserva.nombreApellido)")
                    Text("Teléfono: \(reserva.telefono)")
                    Text("Apartamento: \(reserva.apartamentoSeleccionado)")
                    Text("Método de Pago: \(reserva.metodoPagoSeleccionado)")
                    Text("Cantidad de Habitaciones: \(reserva.cantidadHabitaciones)")
                }
            }
            .onDelete(perform: deleteReservas)
        }
        .onAppear {
            loadReservas()
        }
        .navigationBarTitle("Lista de Reservas")
        .navigationBarItems(trailing: Button("Descargar") {
            showShareSheet = true
        })
        .sheet(isPresented: $showShareSheet) {
            ShareSheet(itemsToShare: [self.reservasComoTexto()])
        }
    }

    private func deleteReservas(at offsets: IndexSet) {
        reservas.remove(atOffsets: offsets)
        saveReservas()
    }

    private func saveReservas() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(reservas) {
            UserDefaults.standard.set(encoded, forKey: "reservas")
        }
    }

    private func loadReservas() {
        if let savedData = UserDefaults.standard.object(forKey: "reservas") as? Data {
            let decoder = JSONDecoder()
            if let loadedReservas = try? decoder.decode([InformacionReserva].self, from: savedData) {
                self.reservas = loadedReservas
            }
        }
    }

    private func reservasComoTexto() -> String {
        reservas.map { reserva in
            """
            Nombre y Apellido: \(reserva.nombreApellido)
            Teléfono: \(reserva.telefono)
            Apartamento: \(reserva.apartamentoSeleccionado)
            Método de Pago: \(reserva.metodoPagoSeleccionado)
            Cantidad de Habitaciones: \(reserva.cantidadHabitaciones)
            ----
            """
        }.joined(separator: "\n")
    }
}

// Previsualización de la vista
struct ListaRegistrosView_Previews: PreviewProvider {
    static var previews: some View {
        ListaRegistrosView()
    }
}
