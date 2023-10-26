import SwiftUI

struct VerCalendarioView: View {
    @State private var selectedDate: Date = Date()
    @State private var eventName: String = ""
    @State private var dates: [Date: String] = [:]

    var body: some View {
        VStack(spacing: 20) {
            VStack{
                
                Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width:300).padding(.bottom, 50)
            }
            Text("Selecciona una fecha:")
            
            DatePicker("", selection: $selectedDate, displayedComponents: .date)
                .labelsHidden()
                .background(Color.white)
                .padding()
            
            TextField("Nombre del evento", text: $eventName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding([.leading, .trailing])
            
            Button("Agregar fecha") {
                if !eventName.isEmpty {
                    dates[selectedDate] = eventName
                    eventName = ""
                }
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)

            List(dates.keys.sorted(), id: \.self) { date in
                HStack {
                    Text(dateString(from: date))
                    Spacer()
                    Text(dates[date] ?? "")
                }
            }
        }
        .navigationBarTitle("Calendario", displayMode: .inline)
    }
    
    func dateString(from date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
#Preview {
    VerCalendarioView()
}
