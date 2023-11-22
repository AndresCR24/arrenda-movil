import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Spacer()
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity: 1.0).ignoresSafeArea()
                VStack {
                    Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width: 300).padding(.bottom, 50)
                    InicioYRegistroView()
                }
            }.navigationBarHidden(true)
        }
    }
}

struct InicioYRegistroView: View {
    @State var tipoInicioSesion = true

    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("INICIA SESIÓN") {
                    tipoInicioSesion = true
                }
                .foregroundColor(tipoInicioSesion ? .white : .gray)
                Spacer()
                Button("REGISTRATE") {
                    tipoInicioSesion = false
                }
                .foregroundColor(tipoInicioSesion ? .gray : .white)
                Spacer()
            }
            Spacer(minLength: 50)
            
            if tipoInicioSesion {
                InicioSesionView()
            } else {
                RegistroView()
            }
        }
    }
}

struct InicioSesionView: View {
    @State var correo = ""
    @State var password = ""
    @State var isPantallaHomeActive = false
    @State var alertaErrorInicio = false

    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                Text("Correo electronico")
                    .foregroundColor(Color("dark-cian"))

                ZStack(alignment: .leading) {
                    if correo.isEmpty {
                        Text("ejemplocorreo@soyudemedellin.com")
                            .font(.caption)
                            .foregroundColor(Color("textos-ejemplo"))
                    }
                    TextField("", text: $correo)
                        .foregroundColor(.white)
                }
                Divider().frame(height: 2).background(Color("dark-cian")).padding(.bottom)
                
                Text("Contraseña")
                    .foregroundColor(Color("dark-cian"))
                ZStack(alignment: .leading) {
                    if password.isEmpty {
                        Text("escribe tu contraseña")
                            .font(.caption)
                            .foregroundColor(Color("textos-ejemplo"))
                    }
                    SecureField("", text: $password)
                        .foregroundColor(.white)
                }
                Divider().frame(height: 2).background(Color("dark-cian")).padding(.bottom)
                
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(width: 300, alignment: .trailing)
                    .foregroundColor(Color("dark-cian"))
                    .padding(.bottom)
                
                Button(action: iniciarSesion) {
                    Text("INICIAR SESION")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color("dark-cian"), lineWidth: 3.0)
                                    .shadow(color: .white, radius: 2))
                }
            }
            .padding(.horizontal, 77.0)
            
            NavigationLink(
                destination: Home(),
                isActive: $isPantallaHomeActive,
                label: { EmptyView() }
            )
        }
        .alert(isPresented: $alertaErrorInicio) {
            Alert(title: Text("Error"), message: Text("Error en el correo o la contraseña"), dismissButton: .default(Text("OK")))
        }
    }

    func iniciarSesion() {
        let usuarios = UserDefaults.standard.dictionary(forKey: "usuarios") as? [String: String] ?? [:]
        if let storedPassword = usuarios[correo], storedPassword == password {
            isPantallaHomeActive = true
        } else {
            alertaErrorInicio = true
        }
    }
}

struct RegistroView: View {
    @State var correo = ""
    @State var password = ""
    @State var confirmarPassword = ""

    var body: some View {
        ScrollView {
            VStack(alignment: .center) {
                Text("Elije una foto de perfil")
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Text("Puedes cambiar o elegirla más adelante")
                    .font(.footnote)
                    .fontWeight(.light)
                    .foregroundColor(.gray)
                    .padding(.bottom)
                
                Button(action: tomarFoto, label: {
                    ZStack {
                        Image("imagenPerfilEjemplo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                        
                        Image(systemName: "camera").foregroundColor(.white)
                    }
                })

                VStack(alignment: .leading) {
                    Text("Correo electronico*")
                        .foregroundColor(Color("dark-cian"))
                    
                    ZStack(alignment: .leading) {
                        if correo.isEmpty {
                            Text("ejemplocorreo@soyudemedellin.com")
                                .font(.caption)
                                .foregroundColor(Color("textos-ejemplo"))
                        }
                        TextField("", text: $correo)
                            .foregroundColor(.white)
                    }
                    Divider().frame(height: 2).background(Color("dark-cian")).padding(.bottom)
                    
                    Text("Contraseña*")
                        .foregroundColor(Color("dark-cian"))
                    ZStack(alignment: .leading) {
                        if password.isEmpty {
                            Text("escribe tu contraseña")
                                .font(.caption)
                                .foregroundColor(Color("textos-ejemplo"))
                        }
                        SecureField("", text: $password)
                            .foregroundColor(.white)
                    }
                    Divider().frame(height: 2).background(Color("dark-cian")).padding(.bottom)
                    
                    Text("Confirmar contraseña*")
                        .foregroundColor(Color("dark-cian"))
                    ZStack(alignment: .leading) {
                        if confirmarPassword.isEmpty {
                            Text("Confirma tu contraseña")
                                .font(.caption)
                                .foregroundColor(Color("textos-ejemplo"))
                        }
                        SecureField("", text: $confirmarPassword)
                            .foregroundColor(.white)
                    }
                    Divider().frame(height: 2).background(Color("dark-cian")).padding(.bottom)
                    
                    Button(action: registrate, label: {
                        Text("REGISTRATE")
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                            .overlay(RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color("dark-cian"), lineWidth: 3.0)
                                        .shadow(color: .white, radius: 2))
                    })
                }
                .padding(.horizontal, 77.0)
            }
        }
    }

    func registrate() {
        guard password == confirmarPassword, !correo.isEmpty, !password.isEmpty else {
            print("Error en el registro: Asegúrese de que todos los campos estén llenos y las contraseñas coincidan.")
            return
        }

        var usuarios = UserDefaults.standard.dictionary(forKey: "usuarios") as? [String: String] ?? [:]
        usuarios[correo] = password // Esto sobrescribe cualquier entrada existente para el mismo correo.
        UserDefaults.standard.set(usuarios, forKey: "usuarios")
        print("Usuario registrado: \(usuarios)")
    }
}

func tomarFoto() {
    print("Voy a tomar foto de perfil")
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
