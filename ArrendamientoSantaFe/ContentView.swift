import SwiftUI

let CORREO_DEFAULT = "4"
let PASSWORD_DEFAULT = "4"


struct ContentView: View
{
    var body: some View 
    {
        NavigationView {
            ZStack
            {
                Spacer()
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity:1.0).ignoresSafeArea()
                VStack{
                    
                    Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width:300).padding(.bottom, 50)
                    
                    InicioYRegistroView()
                }
        }.navigationBarHidden(true)
        }
    }
        
}

struct InicioYRegistroView:View 
{
    
    @State var tipoInicioSesion = true
    
    
    var body: some View{
        
        VStack{
            HStack {
                Spacer()
                Button("INICIA SESIÓN"){
                    tipoInicioSesion = true
                    print("Pantalla inicio sesion")
                }
                .foregroundColor(tipoInicioSesion ? .white: .gray)
                Spacer()
                Button("REGISTRATE") {
                    tipoInicioSesion = false
                    print("Pantalla de registro")
                }
                .foregroundColor(tipoInicioSesion ? .gray: .white)

                Spacer()
                
            }
            Spacer(minLength: 50)
            
            if tipoInicioSesion == true {
                InicioSesionView()
            }else{
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
    var body: some View{
        
        
        ScrollView {
            
            VStack(alignment: .leading) {
                
                Text("Correo electronico")
                    .foregroundColor(Color("dark-cian"))
                
                //Correo
                ZStack(alignment:.leading){
                    
                    if correo.isEmpty{
                        Text("ejemplocorreo@soyudemedellin .com")
                            .font(.caption).foregroundColor(Color("textos-ejemplo"))
                    }
                    TextField("", text: $correo).foregroundColor(.white)
                }
                
                Divider().frame( height:2).background(Color("dark-cian")).padding(.bottom)
                
                //Password
                Text("Contaseña")
                    .foregroundColor(Color("dark-cian"))
                ZStack(alignment:.leading){
                    
                    if password.isEmpty{
                        Text("escribe tu contraseña")
                            .font(.caption).foregroundColor(Color("textos-ejemplo"))
                    }
                    SecureField("", text: $password).foregroundColor(.white)
                }
                
                Divider().frame( height:2).background(Color("dark-cian")).padding(.bottom)
                
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(width: 300, alignment: .trailing)
                    .foregroundColor(Color("dark-cian"))
                    .padding(.bottom)
                
                //NavigationLink(destination: Home()) {
                    Button(action: iniciarSesion, label: {
                        Text("INICIAR SESION")
                            .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                            .foregroundColor(.white)
                            .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                            .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                            .overlay(RoundedRectangle (cornerRadius: 6)
                                .stroke(Color("dark-cian"), lineWidth: 3.0)
                                .shadow(color: .white, radius: 2))
                        
                    })
                }.padding(.horizontal, 77.0)
            //}
            
            NavigationLink(
            destination: Home(),
            isActive: $isPantallaHomeActive,
            label: {
                EmptyView()
            })
        }.alert(isPresented: $alertaErrorInicio) {
            Alert(title: Text("Error"),
                  message: Text("Error en el correo o la contraseña"),
                  dismissButton: .default(Text("OK")))
        }

    
    }
    
    func iniciarSesion(){
        if correo == CORREO_DEFAULT && password == PASSWORD_DEFAULT {
            print("Estoy iniciando sesion")
            isPantallaHomeActive = true
        } else {
            alertaErrorInicio = true
            // Puedes añadir aquí alguna alerta o feedback visual para informar al usuario
        }
    }
}

struct RegistroView: View {
    @State var correo = ""
    @State var password = ""
    @State var confirmarPassword = ""
    
    var body: some View {
        
        //Imagen de perfil
        ScrollView{
            VStack(alignment: .center){
                
                Text("Elije una foto de perfil")
                    .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
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
            }
            
            
            VStack(alignment: .leading) {
                
                Text("Correo electronico*")
                    .foregroundColor(Color("dark-cian"))
                
                //Correo
                ZStack(alignment:.leading){
                    
                    if correo.isEmpty{
                        Text("ejemplocorreo@soyudemedellin .com")
                            .font(.caption).foregroundColor(Color("textos-ejemplo"))
                    }
                    TextField("", text: $correo).foregroundColor(.white)
                }
                
                Divider().frame( height:2).background(Color("dark-cian")).padding(.bottom)
                
                //Password
                Text("Contaseña*")
                    .foregroundColor(Color("dark-cian"))
                ZStack(alignment:.leading){
                    
                    if password.isEmpty{
                        Text("escribe tu contraseña")
                            .font(.caption).foregroundColor(Color("textos-ejemplo"))
                    }
                    SecureField("", text: $password).foregroundColor(.white)
                }
                
                Divider().frame( height:2).background(Color("dark-cian")).padding(.bottom)
                
                Text("confirmar Contrasela*")
                    .foregroundColor(Color("dark-cian"))
                ZStack(alignment:.leading){
                    
                    if password.isEmpty{
                        Text("Confirma tu contraseña")
                            .font(.caption).foregroundColor(Color("textos-ejemplo"))
                    }
                    SecureField("", text: $confirmarPassword).foregroundColor(.white)
                }
                Divider().frame( height:2).background(Color("dark-cian")).padding(.bottom)
                
                
                //                Text("¿Olvidaste tu contraseña?")
                //                    .font(.footnote)
                //                    .frame(width: 300, alignment: .trailing)
                //                    .foregroundColor(Color("dark-cian"))
                //                    .padding(.bottom)
                
                Button(action: registrate, label: {
                    Text("REGISTRATE")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                })
            }.padding(.horizontal, 77.0)
        }
    }
}


func tomarFoto(){
    print("Voy a tomar foto de perfil")
}

func registrate(){
    print("Te registraste")
}

struct ContentView_previews: PreviewProvider
{
    static var previews: some View
    {
        ContentView()
        Image("pantalla1").resizable()
        Image("pantalla2").resizable()
    }
}

