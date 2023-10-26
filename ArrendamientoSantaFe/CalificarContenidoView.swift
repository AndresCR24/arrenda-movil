import SwiftUI

struct CalificarContenidoView: View {
    @State private var nuevoComentario: String = ""
    @State private var comentarios: [String] {
        didSet {
            guardarComentarios()
        }
    }

    init() {
        if let data = UserDefaults.standard.data(forKey: "comentarios"),
           let storedComentarios = try? JSONDecoder().decode([String].self, from: data) {
            _comentarios = State(initialValue: storedComentarios)
        } else {
            _comentarios = State(initialValue: [])
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            TextField("Escribe tu comentario aquí...", text: $nuevoComentario)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Enviar comentario") {
                if !nuevoComentario.isEmpty {
                    comentarios.append(nuevoComentario)
                    nuevoComentario = ""
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            List {
                ForEach(comentarios.indices, id: \.self) { index in
                    HStack {
                        Text(comentarios[index])
                        Spacer()
                        Button(action: {
                            comentarios.remove(at: index)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
            }
        }
        .navigationBarTitle("Comentarios", displayMode: .inline)
    }

    func guardarComentarios() {
        if let data = try? JSONEncoder().encode(comentarios) {
            UserDefaults.standard.set(data, forKey: "comentarios")
        }
    }
}

struct ComentariosView_Previews: PreviewProvider {
    static var previews: some View {
        CalificarContenidoView()
    }
}

#Preview {
    CalificarContenidoView()
}
