import SwiftUI

struct ContentView: View 
{
    var body: some View 
    {
      ZStack
        {
            Spacer()
            Color(red: 19/255, green: 30/255, blue: 53/255, opacity:1.0).ignoresSafeArea()
            VStack{
                
                Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width:300).padding(.bottom, 50)
                
                InicioYRegistroView()
            }
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
                    TextField("", text: $correo).foregroundColor(.red)
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
                    SecureField("", text: $password).foregroundColor(.red)
                }
                
                Divider().frame( height:2).background(Color("dark-cian")).padding(.bottom)
                
                Text("¿Olvidaste tu contraseña?")
                    .font(.footnote)
                    .frame(width: 300, alignment: .trailing)
                    .foregroundColor(Color("dark-cian"))
                    .padding(.bottom)
                
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
        }
    }
}

struct RegistroView: View {
    var body: some View {
        
        
        ScrollView {
            
            VStack {
                
                
                Text("Soy la vista de Registro")
            }
        }
    }
}

func iniciarSesion(){
    print("Estoy iniciando sesion")
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

