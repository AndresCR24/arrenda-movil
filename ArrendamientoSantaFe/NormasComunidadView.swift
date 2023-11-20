import SwiftUI
import PDFKit
import UniformTypeIdentifiers

struct NormasComunidadView: View {
    @State private var isDocumentPickerPresented = false
    @State private var selectedDocumentName: String?
    @State private var isShowingPDF = false
    @State private var documentNames: [String] = []

    let normasDocumentsDirectory: URL

    init() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let newDirectory = documentsDirectory.appendingPathComponent("NormasDocuments")
        if !fileManager.fileExists(atPath: newDirectory.path) {
            try? fileManager.createDirectory(at: newDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        normasDocumentsDirectory = newDirectory
        _documentNames = State(initialValue: Self.listDocuments(in: newDirectory))
    }

    var body: some View {
        NavigationView {
            List {
                ForEach(documentNames, id: \.self) { documentName in
                    Button(documentName) {
                        selectedDocumentName = documentName
                        isShowingPDF = true
                    }
                }
            }
            .navigationBarTitle("Normas de la Comunidad", displayMode: .inline)
            .sheet(isPresented: $isDocumentPickerPresented) {
                DocumentPicker(documentURLs: $documentNames, directory: normasDocumentsDirectory)
            }
            .sheet(isPresented: $isShowingPDF) {
                if let documentName = selectedDocumentName,
                   let pdfDocument = loadDocument(named: documentName) {
                    FullScreenPDFView(pdfDocument: pdfDocument)
                }
            }
            .onAppear {
                documentNames = Self.listDocuments(in: normasDocumentsDirectory)
            }
            .navigationBarItems(trailing: Button(action: {
                isDocumentPickerPresented = true
            }) {
                Image(systemName: "plus")
            })
        }
    }

    func loadDocument(named name: String) -> PDFDocument? {
        let url = normasDocumentsDirectory.appendingPathComponent(name)
        return PDFDocument(url: url)
    }

    static func listDocuments(in directory: URL) -> [String] {
        do {
            let items = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            return items.map { $0.lastPathComponent }
        } catch {
            print("Error al listar documentos: \(error.localizedDescription)")
            return []
        }
    }
}

struct FullScreenPDFView2: View {
    var pdfDocument: PDFDocument

    var body: some View {
        PDFViewWrapper(pdf: pdfDocument)
            .edgesIgnoringSafeArea(.all)
    }
}

struct PDFViewWrapper2: UIViewRepresentable {
    var pdf: PDFDocument

    func makeUIView(context: Context) -> PDFView {
        let pdfView = PDFView()
        pdfView.document = pdf
        pdfView.autoScales = true
        return pdfView
    }

    func updateUIView(_ uiView: PDFView, context: Context) {
        uiView.document = pdf
    }
}

struct NormasComunidadView_Previews: PreviewProvider {
    static var previews: some View {
        NormasComunidadView()
    }
}
