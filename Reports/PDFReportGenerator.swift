import Foundation
import PDFKit
import SwiftUI

class PDFReportGenerator {
    static func generateReport(for trips: [Trip]) -> Data? {
        let pdfMetaData = [
            kCGPDFContextCreator: "MesDéplacements",
            kCGPDFContextAuthor: "Votre App"
        ]
        let format = UIGraphicsPDFRendererFormat()
        format.documentInfo = pdfMetaData as [String: Any]
        
        let pageWidth = 595.2
        let pageHeight = 841.8
        let renderer = UIGraphicsPDFRenderer(bounds: CGRect(x: 0, y: 0, width: pageWidth, height: pageHeight), format: format)
        
        let data = renderer.pdfData { context in
            context.beginPage()
            let title = "Rapport de trajets"
            let titleAttributes: [NSAttributedString.Key: Any] = [
                .font: UIFont.boldSystemFont(ofSize: 24)
            ]
            title.draw(at: CGPoint(x: 72, y: 72), withAttributes: titleAttributes)
            
            var y = 120.0
            for trip in trips {
                let tripString = "Départ: \(trip.startLocation.address ?? "-")\nArrivée: \(trip.endLocation.address ?? "-")\nDistance: \(Int(trip.distance)) m\nÉmissions: \(Int(trip.emissions)) gCO₂\n"
                let attributes: [NSAttributedString.Key: Any] = [
                    .font: UIFont.systemFont(ofSize: 14)
                ]
                tripString.draw(at: CGPoint(x: 72, y: y), withAttributes: attributes)
                y += 60
            }
        }
        return data
    }
} 