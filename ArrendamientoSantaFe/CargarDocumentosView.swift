import SwiftUI
import PDFKit

struct CargarDocumentosView: View {
    @State private var isDocumentPickerPresented = false
    @State private var pdfDocument: PDFDocument?
    @State private var documentNames: [String] = []

    // Directorio de documentos de la aplicación
    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    var body: some View {
        NavigationView {
            ZStack {
                Color(red: 19/255, green: 30/255, blue: 53/255, opacity:1.0).ignoresSafeArea()
                VStack {
                    Image("logosantafe").resizable().aspectRatio(contentMode: .fit).frame(width:300).padding(.bottom, 50)
                    
                    Text("Cargar documentos")
                        .foregroundColor(.white)
                    
                    List(documentNames, id: \.self) { documentName in
                        HStack {
                            Text(documentName) // Muestra el nombre del documento
                                .onTapGesture {
                                    loadDocument(named: documentName) // Carga el documento al tocar el nombre
                                }
                            Spacer()
                            Button(action: {
                                deleteDocument(named: documentName) // Elimina el documento al tocar el botón
                            }) {
                                Image(systemName: "trash") // Icono de papelera
                                    .foregroundColor(.red)
                            }
                        }
                    }
                    
                    if let pdf = pdfDocument {
                        PDFViewWrapper(pdf: pdf)
                            .frame(maxHeight: 400)
                    }
                    
                    Button("Seleccionar PDF") {
                        isDocumentPickerPresented = true
                    }
                }
            }
            .navigationBarHidden(true)
            .fileImporter(isPresented: $isDocumentPickerPresented, allowedContentTypes: [.pdf]) { result in
                switch result {
                case .success(let url):
                    saveDocument(from: url)
                    listDocuments()
                case .failure(let error):
                    print("Error al importar el archivo: \(error.localizedDescription)")
                }
            }
            .onAppear {
                listDocuments()  // Cargar la lista de documentos al iniciar la vista
            }
        }
    }
    
    func saveDocument(from url: URL) {
        let destination = documentsDirectory.appendingPathComponent(url.lastPathComponent)
        do {
            if FileManager.default.fileExists(atPath: destination.path) {
                try FileManager.default.removeItem(at: destination)
            }
            try FileManager.default.copyItem(at: url, to: destination)
        } catch {
            print("Error al guardar el documento: \(error.localizedDescription)")
        }
    }
    
    func listDocuments() {
        do {
            let items = try FileManager.default.contentsOfDirectory(at: documentsDirectory, includingPropertiesForKeys: nil)
            documentNames = items.map { $0.lastPathComponent }
        } catch {
            print("Error al listar documentos: \(error.localizedDescription)")
        }
    }
    
    func loadDocument(named name: String) {
        let url = documentsDirectory.appendingPathComponent(name)
        pdfDocument = PDFDocument(url: url)
    }
    
    func deleteDocument(named name: String) {
        let url = documentsDirectory.appendingPathComponent(name)
        do {
            if FileManager.default.fileExists(atPath: url.path) {
                try FileManager.default.removeItem(at: url)
                // Actualizar la lista de documentos después de eliminar
                listDocuments()
            }
        } catch {
            print("Error al eliminar el documento: \(error.localizedDescription)")
        }
    }
}

struct PDFViewWrapper: UIViewRepresentable {
    var pdf: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.autoScales = true
        pdfView.document = pdf
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdf
    }
}

struct CargarDocumentosView_Previews: PreviewProvider {
    static var previews: some View {
        CargarDocumentosView()
    }
}
