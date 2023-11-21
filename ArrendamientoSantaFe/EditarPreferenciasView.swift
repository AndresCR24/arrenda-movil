import SwiftUI

struct EditarPreferenciasView: View {
    @AppStorage("tieneMascotas") private var tieneMascotas = false
    @AppStorage("ubicacionSeleccionada") private var ubicacionSeleccionada = "Envigado"
    @AppStorage("rangoPrecioSeleccionado") private var rangoPrecioSeleccionado = "menos de 1m"
    @AppStorage("numHabitacionesSeleccionado") private var numHabitacionesSeleccionado = "1"

    var ubicaciones = ["Envigado", "Poblado", "Laureles", "Sabaneta"]
    var rangosPrecio = ["menos de 1m", "mas de 1m", "mas de 5m"]
    var numHabitaciones = ["1", "2", "3", "4", "5", "6", "7+"]

    var body: some View {
        NavigationView {
        
            
            Form {
                
                Toggle("Mascotas", isOn: $tieneMascotas)

                Picker("Ubicación", selection: $ubicacionSeleccionada) {
                    ForEach(ubicaciones, id: \.self) {
                        Text($0)
                    }
                }

                Picker("Rango de precio", selection: $rangoPrecioSeleccionado) {
                    ForEach(rangosPrecio, id: \.self) {
                        Text($0)
                    }
                }

                Picker("Número de habitaciones", selection: $numHabitacionesSeleccionado) {
                    ForEach(numHabitaciones, id: \.self) {
                        Text($0)
                        
                    }
                }
            }
            
            .navigationBarTitle("Editar Preferencias")
            
            
        }
    }
}

struct EditarPreferenciasView_Previews: PreviewProvider {
    static var previews: some View {
        EditarPreferenciasView()
    }
}
