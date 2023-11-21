import SwiftUI

struct AgendarVisitaView: View {
    
    @State private var nombreApellido: String = ""
    @State private var telefono: String = ""
    @State private var apartamentoSeleccionado: String = "POBLADO"
    @State private var metodoPagoSeleccionado: String = "EFECTIVO"
    @State private var cantidadHabitaciones: Int = 1
    @State private var mostrarCantidadHabitaciones: Bool = false
    @State private var mostrarAlerta = false
    
    let apartamentos = ["POBLADO", "ENVIGADO", "LAURELES", "SABANETA"]
    let metodosPago = ["EFECTIVO", "TRANSFERENCIA", "BITCOIN", "TARJETA CREDITO"]
    
    // Estructura para almacenar la información
    struct InformacionReserva: Identifiable, Codable {
        var id = UUID()
        var nombreApellido: String
        var telefono: String
        var apartamentoSeleccionado: String
        var metodoPagoSeleccionado: String
        var cantidadHabitaciones: Int
    }
    
    // Variable para almacenar la información ingresada por el usuario
    @State private var reservas: [InformacionReserva] = []
    
    // Variable para indicar si las reservas se han cargado desde UserDefaults
    @State private var reservasCargadas: Bool = false
    
    init() {
        // Llama a la superclase de init
        // Carga las reservas solo una vez cuando se crea la vista
        _reservas = State(initialValue: loadReservas())
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("¡Bienvenido a Arrendamientos santafe!")) {
                    TextField("Ingresa nombre y apellido", text: $nombreApellido)
                    TextField("Ingresa número de teléfono", text: $telefono)
                    Picker("APARTAMENTOS:", selection: $apartamentoSeleccionado) {
                        ForEach(apartamentos, id: \.self) {
                            Text($0)
                        }
                    }
                    Picker("MÉTODO DE PAGO:", selection: $metodoPagoSeleccionado) {
                        ForEach(metodosPago, id: \.self) {
                            Text($0)
                        }
                    }
                    Toggle(isOn: $mostrarCantidadHabitaciones) {
                        Text("Seleccionar cantidad de habitaciones:")
                    }
                    if mostrarCantidadHabitaciones {
                        Picker("CANTIDAD DE HABITACIONES:", selection: $cantidadHabitaciones) {
                            ForEach(1..<5, id: \.self) {
                                Text("\($0) \($0 == 1 ? "HABITACIÓN" : "HABITACIONES")")
                            }
                        }
                    }
                }
                
                Button(action: {
                    // Guardar la información en la variable reservas
                    let nuevaReserva = InformacionReserva(
                        nombreApellido: nombreApellido,
                        telefono: telefono,
                        apartamentoSeleccionado: apartamentoSeleccionado,
                        metodoPagoSeleccionado: metodoPagoSeleccionado,
                        cantidadHabitaciones: cantidadHabitaciones
                    )
                    
                    reservas.append(nuevaReserva)
                    
                    // Guardar las reservas en UserDefaults
                    saveReservas()
                    
                    // Mostrar la alerta
                    self.mostrarAlerta = true
                }) {
                    Text("ENVIAR")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .alert(isPresented: $mostrarAlerta) {
                    Alert(
                        title: Text("Información Enviada"),
                        message: Text("Tu información ha sido enviada exitosamente."),
                        dismissButton: .default(Text("OK"))
                    )
                }
                
                // Mostrar la información de las reservas guardadas
                Section(header: Text("Reservas Guardadas")) {
                    List {
                        ForEach(reservas) { reserva in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text("Nombre y Apellido: \(reserva.nombreApellido)")
                                    Text("Teléfono: \(reserva.telefono)")
                                    Text("Apartamento: \(reserva.apartamentoSeleccionado)")
                                    Text("Método de Pago: \(reserva.metodoPagoSeleccionado)")
                                    Text("Cantidad de Habitaciones: \(reserva.cantidadHabitaciones)")
                                }
                                Spacer()
                                Button(action: {
                                    // Eliminar la reserva
                                    if let index = reservas.firstIndex(where: { $0.id == reserva.id }) {
                                        reservas.remove(at: index)
                                        saveReservas()
                                    }
                                }) {
                                    Image(systemName: "trash")
                                        .foregroundColor(.red)
                                }
                            }
                        }
                    }
                }
                
                NavigationLink(destination: ListaRegistrosView()) {
                    Text("Ver lista de reservas")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
            }
            .navigationBarTitle("Regístrate y encuentra lo que buscas:", displayMode: .inline)
        }
    }
    
    // Función para cargar las reservas guardadas desde UserDefaults
    func loadReservas() -> [InformacionReserva] {
        if !reservasCargadas, let data = UserDefaults.standard.data(forKey: "reservas") {
            let decoder = JSONDecoder()
            if let reservas = try? decoder.decode([InformacionReserva].self, from: data) {
                reservasCargadas = true
                return reservas
            }
        }
        return []
    }
    
    // Función para guardar las reservas en UserDefaults
    func saveReservas() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(reservas) {
            UserDefaults.standard.set(encoded, forKey: "reservas")
        }
    }
}

struct AgendarVisitaView_Previews: PreviewProvider {
    static var previews: some View {
        AgendarVisitaView()
    }
}
