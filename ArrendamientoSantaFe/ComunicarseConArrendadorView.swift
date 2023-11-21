import SwiftUI
import UserNotifications // Importa UserNotifications

struct ChatMessage: Identifiable {
    var id = UUID()
    var text: String
    var isUser: Bool
}

struct ComunicarseConArrendadorView: View {
    @State private var contractInfo = ""
    @State private var messages: [ChatMessage] = []
    @State private var newMessage = ""

    var body: some View {
        VStack {
            TextField("Ingrese información del contrato", text: $contractInfo)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            ScrollView {
                LazyVStack {
                    ForEach(messages) { message in
                        ChatBubble(message: message)
                            .padding(.horizontal)
                    }
                }
            }
            .frame(maxHeight: .infinity)

            HStack {
                TextField("Escribe un mensaje", text: $newMessage)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal)

                Button(action: sendMessage) {
                    Text("Enviar")
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding(.vertical, 10)
                        .padding(.horizontal, 20)
                        .background(Color("dark-cian"))
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .onAppear {
            // Solicitar permiso para mostrar notificaciones cuando aparece la vista
            requestNotificationPermission()
        }
    }

    func sendMessage() {
        if !newMessage.isEmpty {
            let message = ChatMessage(text: newMessage, isUser: true)
            messages.append(message)
            newMessage = ""
            
            // Configura y muestra una notificación local
            sendNotification()
        }
    }

    func sendNotification() {
        let content = UNMutableNotificationContent()
        content.title = "Nuevo mensaje"
        content.body = "Se recibió un mensaje del arrendatario de tu propiedad con número de contrato #\(contractInfo). Entra en la aplicación para comunicarte con él."
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false) // Puedes ajustar el tiempo aquí
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { (error) in
            if let error = error {
                print("Error al enviar la notificación: \(error.localizedDescription)")
            }
        }
    }

    // Solicitar permiso para notificaciones locales
    func requestNotificationPermission() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if granted {
                print("Permiso otorgado para notificaciones locales")
            } else if let error = error {
                print("Error al solicitar permiso para notificaciones: \(error.localizedDescription)")
            }
        }
    }
}

struct ChatBubble: View {
    var message: ChatMessage

    var body: some View {
        Group {
            if message.isUser {
                HStack {
                    Spacer()
                    Text(message.text)
                        .padding(10)
                        .background(Color("dark-cian"))
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            } else {
                HStack {
                    Text(message.text)
                        .padding(10)
                        .background(Color("light-gray"))
                        .cornerRadius(10)
                    Spacer()
                }
            }
        }
    }
}

struct ComunicarseConArrendadorView_Previews: PreviewProvider {
    static var previews: some View {
        ComunicarseConArrendadorView()
    }
}
