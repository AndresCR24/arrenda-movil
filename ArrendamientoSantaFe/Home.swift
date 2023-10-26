import SwiftUI


struct Home: View
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
                    
                    HomeView()
                }
        }.navigationBarHidden(true)
        }
    }
        
}

struct HomeView: View {
    
    var body: some View {
        
        //NavigationView{
            VStack(spacing: 20) {
                
                NavigationLink(destination: ContratosView()) {
                    Text("Ver contratos")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle(cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                }
                NavigationLink(destination: HistorialPagosView()) {
                    Text("Ver historial del pagos")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                NavigationLink(destination: HistorialFacturasView()){
                    Text("Ver historial de facturas")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                NavigationLink(destination: NormasComunidadView()) {
                    Text("Ver normas de la comunidad")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                NavigationLink(destination: AgendarVisitaView()){
                    Text("Agendar visita")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                NavigationLink(destination: CargarDocumentosView()) {
                    Text("CARGAR DOCUMENTOS")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                
                NavigationLink(destination: VerCalendarioView()) {
                    Text("VER CALENDARIO")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                NavigationLink(destination: VerPerfilView()) {
                    Text("VER PERFIL")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                NavigationLink(destination: VerPropiedadView()) {
                    Text("VER PROPIEDADES")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
                
                NavigationLink(destination: CalificarContenidoView()) {
                    Text("CALIFICAR CONTENIDO")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 2))
                    
                }
            }
            .padding(.top, 30)
            
        }
    }
//}

func verPerfil(){
    print("Voy a ver el perfil")
}

func verCalendario(){
    print("Estoy viendo calendario")
}

func cargarDocumentos(){
    print("Estoy cargando documentos")
}

func agendarVisita(){
    print("Estoy agendando visita")
}

func normasComunidad(){
    print("viendo normas de la comunidad")
}

func historialFacturas(){
    print("viendo facturas")
}

func historialPagos(){
    print("Viendo historial pagos")
}

func verContratos(){
    print("Viendo contratos")
}

func verPropiedad(){
    print("viendo propiedad")
}


#Preview {
    Home()
}
