import SwiftUI

struct CambioPasswordView: View {
    @State private var nuevaContraseña: String = ""
    @State private var confirmarContraseña: String = ""
    @State private var showAlert: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            SecureField("Escribe tu nueva contraseña", text: $nuevaContraseña)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            SecureField("Confirmar contraseña", text: $confirmarContraseña)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)
            
            Button("Cambiar Contraseña") {
                if nuevaContraseña == confirmarContraseña {
                    showAlert = true
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Contraseña Cambiada"),
                      message: Text("Contraseña cambiada con éxito"),
                      dismissButton: .default(Text("Aceptar")))
            }
        }
        .padding()
    }
}

struct CambioPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        CambioPasswordView()
    }
}

#Preview {
    CambioPasswordView()
}
