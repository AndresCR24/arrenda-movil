import SwiftUI
/*
struct VerPerfilView: View {
    @State private var selectedImage: UIImage? = UIImage(named: "defaultProfile")  // Suponiendo que tienes una imagen por defecto
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity:1.0)
                    .ignoresSafeArea()
                
                VStack {
                    Image("logosantafe")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 300)
                        .padding(.top, 60)
                    
                    Spacer()
                    
                    Text("Elige una foto de perfil")
                        .font(.headline)
                        .foregroundColor(.white)
                    
                    Text("Puedes cambiar o elegirla más adelante")
                        .foregroundColor(.white)
                        .opacity(0.7)
                    
                    Image(uiImage: selectedImage ?? UIImage())
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 120, height: 120)
                        .background(Color.white)
                        .cornerRadius(60)
                        .overlay(Circle().stroke(Color.gray, lineWidth: 1))
                        .padding(.top, 10)
                    
                    Spacer()
                    
                    HStack(spacing: 40) {
                        Button("Cambiar contraseña", action: {
                            // Acción de inicio de sesión
                        })
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)  // Puedes cambiar a un color que prefieras
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        
                    
                    }.padding(.bottom, 30) // Espacio desde el borde inferior de la pantalla
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}
 */
// MARK: - Image Picker
struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) private var presentationMode

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        // No se necesita nada aquí
    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    final class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        var parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }

            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - Profile View
struct VerPerfilView: View {
    @State private var selectedImage: UIImage? = nil
    @State private var showImagePicker: Bool = false

    var body: some View {
        NavigationView {
            ZStack {
                Spacer()
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity:1.0).ignoresSafeArea()
                VStack{
                    if let image = selectedImage {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                            .padding(.bottom, 50)
                    } else {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 100)
                            .padding(.bottom, 50)
                    }

                    Button("Cargar Foto de Perfil") {
                        self.showImagePicker.toggle()
                    }
                    .sheet(isPresented: $showImagePicker) {
                        ImagePicker(selectedImage: $selectedImage)
                    }
                    .padding(.bottom, 20)
                    
                    VStack{
                        Text("INFORMACIÓN DEL PERFIL")
                            .foregroundColor(.red)
                            .padding(.bottom, 20)
                        Text("Correo electronico")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        Text("Lasso@gmail.com")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        Text("Cidad: Medellin")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                        Text("Tiene mascotas: Si")
                            .foregroundColor(.white)
                            .padding(.bottom, 20)
                    }

                    Spacer()
               

                    VStack {
                        NavigationLink(destination: CambioPasswordView()) {
                            Text("Cambiar contraseña")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                                .frame(maxWidth: .infinity, alignment: .center)
                                .padding(EdgeInsets(top: 11, leading: 18, bottom: 11, trailing: 18))
                                .overlay(RoundedRectangle(cornerRadius: 6)
                                    .stroke(Color("dark-cian"), lineWidth: 3.0)
                                    .shadow(color: .white, radius: 2))
                        }
                        
                    }
                    .padding(.bottom, 30)
                }
            }.navigationBarHidden(true)
        }
    }
}

struct VerPerfilView_Previews: PreviewProvider {
    static var previews: some View {
        VerPerfilView()
    }
}
#Preview {
    VerPerfilView()
}
