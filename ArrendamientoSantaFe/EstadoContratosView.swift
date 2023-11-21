import SwiftUI
import UIKit
import PDFKit

// MARK: - PDF Document Picker
struct PDFDocumentPicker: UIViewControllerRepresentable {
    @Binding var urlArchivoPDF: URL?
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: PDFDocumentPicker

        init(_ parent: PDFDocumentPicker) {
            self.parent = parent
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            DispatchQueue.main.async {
                self.parent.urlArchivoPDF = url
            }
        }
    }
}

// MARK: - PDF Viewer
struct PDFViewer: View {
    var pdfDocument: PDFDocument

    var body: some View {
        PDFKitView(pdfDocument: pdfDocument)
            .edgesIgnoringSafeArea(.all)
    }
}

struct PDFKitView: UIViewRepresentable {
    let pdfDocument: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdfDocument
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {}
}

// MARK: - Contrato Structure
struct Contrato: Identifiable, Codable {
    let id = UUID()
    var nombre: String
    var fecha: Date
    var activo: Bool
    var pdfFileName: String? // Nombre del archivo PDF en el sistema de archivos local
}

// MARK: - Contrato Data Manager
class ContratoDataManager {
    static let shared = ContratoDataManager()
    private init() {}
    
    func saveContratos(_ contratos: [Contrato]) {
        let encoder = JSONEncoder()
        if let encodedData = try? encoder.encode(contratos) {
            UserDefaults.standard.set(encodedData, forKey: "contratos")
        }
    }
    
    func loadContratos() -> [Contrato] {
        let decoder = JSONDecoder()
        if let savedData = UserDefaults.standard.data(forKey: "contratos"),
           let contratos = try? decoder.decode([Contrato].self, from: savedData) {
            return contratos
        }
        return []
    }
    
    // Guardar archivo PDF en el sistema de archivos local
    func savePDF(_ pdfData: Data, fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        
        do {
            try pdfData.write(to: fileURL)
            return fileURL
        } catch {
            print("Error al guardar el archivo PDF: \(error.localizedDescription)")
            return nil
        }
    }
    
    // Cargar archivo PDF desde el sistema de archivos local
    func loadPDF(_ fileName: String) -> URL? {
        guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentsDirectory.appendingPathComponent(fileName)
        return FileManager.default.fileExists(atPath: fileURL.path) ? fileURL : nil
    }
}

// MARK: - ContratoRowView
struct ContratoRowView: View {
    @State private var isExpanded = false
    var contrato: Contrato
    @State private var isPDFViewerPresented = false
    @Environment(\.presentationMode) var presentationMode
    @Binding var contratos: [Contrato]

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(contrato.nombre)
                    .font(.headline)
                Text("Fecha: \(contrato.fecha, formatter: itemFormatter)")
                    .font(.subheadline)
            }
            Spacer()
            Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
        }
        .onTapGesture {
            withAnimation {
                isExpanded.toggle()
            }
        }

        if isExpanded {
            Text("Activo: \(contrato.activo ? "Sí" : "No")")
            HStack {
                if let fileName = contrato.pdfFileName {
                    Text(fileName)
                        .foregroundColor(.blue)
                        .onTapGesture {
                            isPDFViewerPresented.toggle()
                        }
                } else {
                    Text("Sin PDF")
                        .foregroundColor(.red)
                }

                Spacer()

                Button(action: {
                    eliminarContrato()
                }) {
                    Image(systemName: "trash")
                        .foregroundColor(.red)
                }
            }
            .sheet(isPresented: $isPDFViewerPresented) {
                if let pdfURL = contrato.pdfFileName.flatMap(ContratoDataManager.shared.loadPDF),
                   let pdfDocument = PDFDocument(url: pdfURL) {
                    PDFViewer(pdfDocument: pdfDocument)
                }
            }
        }
    }

    private func eliminarContrato() {
        if let index = contratos.firstIndex(where: { $0.id == contrato.id }) {
            // Eliminar el archivo PDF del sistema de archivos local si existe
            if let fileName = contratos[index].pdfFileName,
               let pdfURL = ContratoDataManager.shared.loadPDF(fileName) {
                do {
                    try FileManager.default.removeItem(at: pdfURL)
                } catch {
                    print("Error al eliminar el archivo PDF: \(error.localizedDescription)")
                }
            }

            contratos.remove(at: index)
            ContratoDataManager.shared.saveContratos(contratos)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

// MARK: - EstadoContratosView
struct EstadoContratosView: View {
    @State private var contratos: [Contrato] = ContratoDataManager.shared.loadContratos()
    @State private var mostrandoAgregarContrato = false

    var body: some View {
        NavigationView {
            List {
                ForEach(contratos) { contrato in
                    ContratoRowView(contrato: contrato, contratos: $contratos)
                }
            }
            .navigationBarTitle("Contratos")
            .navigationBarItems(trailing: Button(action: {
                mostrandoAgregarContrato = true
            }) {
                Image(systemName: "plus")
            })
            .sheet(isPresented: $mostrandoAgregarContrato) {
                AgregarContratoView(contratos: $contratos)
            }
        }
    }
}

// MARK: - AgregarContratoView
struct AgregarContratoView: View {
    @Binding var contratos: [Contrato]
    @Environment(\.presentationMode) var presentationMode
    @State private var nombreContrato = ""
    @State private var contratoActivo = false
    @State private var fechaContrato = Date()
    @State private var mostrarDocumentPicker = false
    @State private var urlArchivoPDF: URL?
    
    var body: some View {
        NavigationView {
            Form {
                TextField("Nombre del Contrato", text: $nombreContrato)
                DatePicker("Fecha del Contrato", selection: $fechaContrato, displayedComponents: .date)
                Toggle("Contrato Activo", isOn: $contratoActivo)
                
                Button("Subir Archivo PDF") {
                    mostrarDocumentPicker = true
                }
                
                Button("Agregar Contrato") {
                    // Eliminar contrato anterior si existe
                    if let index = contratos.firstIndex(where: { $0.nombre == nombreContrato }) {
                        contratos.remove(at: index)
                    }
                    
                    // Guardar el archivo PDF en el sistema de archivos local y actualizar el contrato
                    if let pdfData = try? Data(contentsOf: urlArchivoPDF ?? URL(fileURLWithPath: "")),
                       let fileName = urlArchivoPDF?.lastPathComponent {
                        let nuevoContrato = Contrato(nombre: nombreContrato, fecha: fechaContrato, activo: contratoActivo, pdfFileName: fileName)
                        contratos.append(nuevoContrato)
                        ContratoDataManager.shared.saveContratos(contratos)
                        presentationMode.wrappedValue.dismiss()
                    } else {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .navigationBarTitle("Nuevo Contrato", displayMode: .inline)
            .navigationBarItems(leading: Button("Cancelar") {
                presentationMode.wrappedValue.dismiss()
            })
            .sheet(isPresented: $mostrarDocumentPicker) {
                PDFDocumentPicker(urlArchivoPDF: $urlArchivoPDF)
            }
        }
    }
}

// MARK: - Preview
struct EstadoContratosView_Previews: PreviewProvider {
    static var previews: some View {
        EstadoContratosView()
    }
}

// MARK: - Date Formatter
let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}()
