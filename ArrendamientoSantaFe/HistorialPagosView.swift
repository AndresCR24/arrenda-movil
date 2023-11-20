import SwiftUI
import PDFKit
import UniformTypeIdentifiers

struct HistorialPagosView: View {
    @State private var isDocumentPickerPresented = false
    @State private var selectedDocumentName: String?
    @State private var isShowingPDF = false
    @State private var documentNames: [String] = []

    let newDocumentsDirectory: URL

    init() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        let newDirectory = documentsDirectory.appendingPathComponent("NewDocuments")
        if !fileManager.fileExists(atPath: newDirectory.path) {
            try? fileManager.createDirectory(at: newDirectory, withIntermediateDirectories: true, attributes: nil)
        }
        newDocumentsDirectory = newDirectory
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
            .navigationBarTitle("Historial de Pagos", displayMode: .inline)
            .sheet(isPresented: $isDocumentPickerPresented) {
                DocumentPicker(documentURLs: $documentNames, directory: newDocumentsDirectory)
            }
            .sheet(isPresented: $isShowingPDF) {
                if let documentName = selectedDocumentName,
                   let pdfDocument = loadDocument(named: documentName) {
                    FullScreenPDFView(pdfDocument: pdfDocument)
                }
            }
            .onAppear {
                documentNames = Self.listDocuments(in: newDocumentsDirectory)
            }
            .navigationBarItems(trailing: Button(action: {
                isDocumentPickerPresented = true
            }) {
                Image(systemName: "plus")
            })
        }
    }

    func loadDocument(named name: String) -> PDFDocument? {
        let url = newDocumentsDirectory.appendingPathComponent(name)
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

struct DocumentPicker: UIViewControllerRepresentable {
    @Binding var documentURLs: [String]
    var directory: URL
    @Environment(\.presentationMode) var presentationMode

    func makeUIViewController(context: Context) -> UIDocumentPickerViewController {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf], asCopy: true)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self, directory: directory)
    }

    class Coordinator: NSObject, UIDocumentPickerDelegate {
        var parent: DocumentPicker
        var directory: URL

        init(_ documentPicker: DocumentPicker, directory: URL) {
            self.parent = documentPicker
            self.directory = directory
        }

        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first else { return }
            let destination = directory.appendingPathComponent(url.lastPathComponent)
            do {
                if FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }
                try FileManager.default.copyItem(at: url, to: destination)
                DispatchQueue.main.async {
                    self.parent.documentURLs.append(url.lastPathComponent)
                }
            } catch {
                print("Error al guardar el documento: \(error.localizedDescription)")
            }
            parent.presentationMode.wrappedValue.dismiss()
        }

        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}

struct FullScreenPDFViews: View {
    var pdfDocument: PDFDocument

    var body: some View {
        PDFViewWrapper(pdf: pdfDocument)
            .edgesIgnoringSafeArea(.all)
    }
}

struct PDFViewWrapperr: UIViewRepresentable {
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

struct HistorialPagosView_Previews: PreviewProvider {
    static var previews: some View {
        HistorialPagosView()
    }
}
