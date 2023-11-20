import SwiftUI
import PDFKit

struct ContratosView: View {
    @State private var documentNames: [String] = []
    @State private var selectedDocumentName: String?
    @State private var isShowingPDF = false  // Estado para controlar la presentación de la hoja

    let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

    var body: some View {
        NavigationView {
            List(documentNames, id: \.self) { documentName in
                Button(documentName) {
                    selectedDocumentName = documentName
                    isShowingPDF = true
                }
            }
            .onAppear {
                listDocuments()
            }
            .navigationBarTitle("Historial de Pagos", displayMode: .inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Contratos")
                        .font(.system(size: 24)) // Ajusta el tamaño de la fuente según lo necesites
                        .bold()
                }
            }
            .sheet(isPresented: $isShowingPDF) {
                if let documentName = selectedDocumentName,
                   let pdfDocument = loadDocument(named: documentName) {
                    FullScreenPDFView(pdfDocument: pdfDocument)
                }
            }
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

    func loadDocument(named name: String) -> PDFDocument? {
        let url = documentsDirectory.appendingPathComponent(name)
        return PDFDocument(url: url)
    }
}

struct FullScreenPDFView: View {
    var pdfDocument: PDFDocument

    var body: some View {
        PDFViewWrapper(pdf: pdfDocument)
            .edgesIgnoringSafeArea(.all)
    }
}

// Asegúrate de que la estructura PDFViewWrapper ya esté declarada en otra parte de tu proyecto.

struct ContratosView_Previews: PreviewProvider {
    static var previews: some View {
        ContratosView()
    }
}
