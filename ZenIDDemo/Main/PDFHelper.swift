//
//  PDFHelper.swift
//  ZenIDDemo
//
//  Created by František Kratochvíl on 20/05/2019.
//  Copyright © 2019 Trask, a.s. All rights reserved.
//

import Foundation
import UIKit
import PDFKit

class PDFHelper {

    private let fileManager = FileManager.default
    private let namePrefix = "pdf_"
    var paths: [String] = []

    var finalFilePath: String {
        return NSTemporaryDirectory() + "/" + namePrefix + "_final"
    }

    /**
     * Method name: Create PDF
     * Description: Provides ability to create pdf from image
     * Parameters: image - UIImage from which PDF is created
     */
    func createPDF(from imageData: Data) {
        guard let image = UIImage(data: imageData) else { return }
        
        let path = NSTemporaryDirectory() + "/" + namePrefix + image.hash.description + ".pdf"
        UIGraphicsBeginPDFContextToFile(path, CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height), nil);
        autoreleasepool {
            UIGraphicsBeginPDFPage()
            image.draw(at: .zero)
        }
        UIGraphicsEndPDFContext();
        paths.append(path)
    }

    /**
     * Method name: Merge all PDFs
     * Description: Creates output PDF with all currently stored PDFs in temporaly folder
     */
    func merge() {
        let writePath = finalFilePath

        guard let context = CGContext(URL(fileURLWithPath: writePath) as CFURL, mediaBox: nil, nil) else {
            return
        }

        for path in paths {
            guard let document = CGPDFDocument(URL(fileURLWithPath: path) as CFURL) else {
                continue
            }

            for pageNumber in 1...document.numberOfPages {
                guard let page = document.page(at: pageNumber) else { continue }
                var mediaBox = page.getBoxRect(.mediaBox)
                context.beginPage(mediaBox: &mediaBox)
                context.drawPDFPage(page)
                context.endPage()
            }
        }

        context.closePDF()
        UIGraphicsEndPDFContext()
    }

    /**
     * Method name: Clean up all PDFs from file storage
     * Description: Cleans all stored pdfs by this class - should be called after successfull final pdf upload
     */
    func cleanup() {
        for path in paths {
            guard path.starts(with: namePrefix) else {
                continue
            }
            try? fileManager.removeItem(at: URL(fileURLWithPath: path))
        }

        try? fileManager.removeItem(at: URL(fileURLWithPath: finalFilePath))
        paths = []
    }
}
