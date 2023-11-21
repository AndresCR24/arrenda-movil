import SwiftUI

struct Home: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity:1.0).ignoresSafeArea()
                VStack {
                    Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width: 300).padding(.bottom, 50)
                    HomeView()
                }
            }.navigationBarHidden(true)
        }
    }
}

struct HomeView: View {
    // Define la disposición de los elementos en la cuadrícula
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            LazyVGrid(columns: columns, spacing: 20) {
                // Cada elemento de la cuadrícula es un NavigationLink
                NavigationLink(destination: ContratosView()) {
                    gridButtonLabel("Ver contratos")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                    //.padding(EdgeInsets(top: , leading: 18, bottom: 11, trailing: 18))
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: HistorialPagosView()) {
                    gridButtonLabel("Ver historial del pagos")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: EstadoContratosView()) {
                    gridButtonLabel("Estado de los contratos")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: NormasComunidadView()) {
                    gridButtonLabel("Ver normas de la comunidad")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: AgendarVisitaView()) {
                    gridButtonLabel("Agendar visita")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: CargarDocumentosView()) {
                    gridButtonLabel("CARGAR DOCUMENTOS")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: VerCalendarioView()) {
                    gridButtonLabel("VER CALENDARIO")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: VerPerfilView()) {
                    gridButtonLabel("VER PERFIL")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: VerPropiedadView()) {
                    gridButtonLabel("VER PROPIEDADES")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                }
                NavigationLink(destination: CalificarContenidoView()) {
                    gridButtonLabel("CALIFICAR CONTENIDO")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                    
                }
                NavigationLink(destination: ComunicarseConArrendadorView()) {
                    gridButtonLabel("COMUNICARSE CON ARRENDADOR")
                        .fontWeight(/*@START_MENU_TOKEN@*/.bold/*@END_MENU_TOKEN@*/)
                        .foregroundColor(.white)
                        .frame(maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        .overlay(RoundedRectangle (cornerRadius: 6)
                            .stroke(Color("dark-cian"), lineWidth: 3.0)
                            .shadow(color: .white, radius: 0.5))
                    
                }
                }
                .padding(.top, 10)
            }
        }
        
        
        // Esta función crea la etiqueta para cada botón de la cuadrícula
        func gridButtonLabel(_ text: String) -> some View {
            Text(text)
                .fontWeight(.bold)
                .foregroundColor(Color(.white))
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 94)
            //            .background(Color("dark-cian"))
                .cornerRadius(10)
            //.shadow(color: .white, radius: 2)
                .padding(5)
        }
    }
    
    // No incluir estas estructuras si ya están definidas en otra parte de tu proyecto
    // struct ContratosView: View { /* ... */ }
    // struct HistorialPagosView: View { /* ... */ }
    // struct EstadoContratosView: View { /* ... */ }
    // struct NormasComunidadView: View { /* ... */ }
    // struct AgendarVisitaView: View { /* ... */ }
    // struct CargarDocumentosView: View { /* ... */ }
    // struct VerCalendarioView: View { /* ... */ }
    // struct VerPerfilView: View { /* ... */ }
    // struct VerPropiedadView: View { /* ... */ }
    // struct CalificarContenidoView: View { /* ... */ }
    
    // Preview
    struct Home_Previews: PreviewProvider {
        static var previews: some View {
            Home()
        }
    }

