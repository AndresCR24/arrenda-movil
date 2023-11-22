import SwiftUI

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
    @State private var editingNombre = false
    @State private var editingCorreo = false
    @State private var editingCorreoRespaldo = false
    @State private var editingCiudad = false
    @State private var editingTelefono = false
    @State private var nombre: String = "David Lasso"
    @State private var correoElectronico: String = "Lasso@gmail.com"
    @State private var correoElectronicoRespaldo: String = "Lasso@gmail.com"
    @State private var ciudad: String = "Medellin"
    @State private var telefono: String = "3007078802"

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

                    VStack {
                        Text("INFORMACIÓN DEL PERFIL")
                            .foregroundColor(.red)
                            .padding(.bottom, 20)

                        ProfileInfoRow(title: "Nombre:", value: $nombre, isEditing: $editingNombre)
                        ProfileInfoRow(title: "Correo electrónico:", value: $correoElectronico, isEditing: $editingCorreo)
                        ProfileInfoRow(title: "Correo de respaldo:", value: $correoElectronicoRespaldo, isEditing: $editingCorreoRespaldo)
                        
                        ProfileInfoRow(title: "Ciudad:", value: $ciudad, isEditing: $editingCiudad)
                        ProfileInfoRow(title: "Teléfono:", value: $telefono, isEditing: $editingTelefono)
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
                            
                            NavigationLink(destination: EditarPreferenciasView()) {
                                Text("Editar preferencias")
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .padding(EdgeInsets(top: 11, leading: 18, bottom: 33, trailing: 18))
                                    .overlay(RoundedRectangle(cornerRadius: 6)
                                        .stroke(Color("dark-cian"), lineWidth: 3.0)
                                        .shadow(color: .white, radius: 2))
                            }
                        }
                    }
                    .padding(.bottom, 30)
                }
            }.navigationBarHidden(true)
            
        }
    }
}

struct ProfileInfoRow: View {
    let title: String
    @Binding var value: String
    @Binding var isEditing: Bool

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
            if isEditing {
                TextField("", text: $value)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .foregroundColor(.black)
            } else {
                Text(value)
                    .foregroundColor(.white)
            }
            Spacer()
            Button(action: { isEditing.toggle() }) {
                Image(systemName: isEditing ? "checkmark.circle" : "pencil")
                    .foregroundColor(isEditing ? .green : .white)
            }
        }
        .padding()
    }
}
#Preview {
    VerPerfilView()
}
