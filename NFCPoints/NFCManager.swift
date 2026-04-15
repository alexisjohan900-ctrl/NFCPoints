import Foundation
import CoreNFC

class NFCManager: NSObject, NFCNDEFReaderSessionDelegate, ObservableObject {
    @Published var isScanning = false
    @Published var scannedTag: String?
    @Published var errorMessage: String?
    
    var nfcSession: NFCNDEFReaderSession?
    var completionHandler: ((String?) -> Void)?
    
    func startScanning(completion: @escaping (String?) -> Void) {
        guard NFCNDEFReaderSession.readingAvailable else {
            errorMessage = "NFC is not available on this device"
            return
        }
        
        completionHandler = completion
        isScanning = true
        nfcSession = NFCNDEFReaderSession(delegate: self, queue: .main, invalidateAfterFirstRead: true)
        nfcSession?.alertMessage = "Hold your NFC card to the top of your iPhone"
        nfcSession?.begin()
    }
    
    func stopScanning() {
        isScanning = false
        nfcSession?.invalidate()
    }
    
    // MARK: - NFCNDEFReaderSessionDelegate
    
    func readerSession(_ session: NFCNDEFReaderSession, didInvalidateWithError error: Error) {
        errorMessage = error.localizedDescription
        isScanning = false
        completionHandler?(nil)
    }
    
    func readerSession(_ session: NFCNDEFReaderSession, didDetectNDEFs messages: [NFCNDEFMessage]) {
        isScanning = false
        
        var tagData: String?
        for message in messages {
            for record in message.records {
                if let identifier = record.identifier.count > 0 ? String(data: record.identifier, encoding: .utf8) : nil {
                    tagData = identifier
                    break
                } else if let payload = String(data: record.payload, encoding: .utf8) {
                    tagData = payload
                    break
                }
            }
            if tagData != nil {
                break
            }
        }
        
        if tagData == nil {
            tagData = UUID().uuidString
        }
        
        scannedTag = tagData
        completionHandler?(tagData)
    }
    
    // Fallback for raw NFC tag detection
    func readerSessionDidBecomeActive(_ session: NFCNDEFReaderSession) {
        // Session is active
    }
}
