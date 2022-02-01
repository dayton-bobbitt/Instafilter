//
//  ImageSaver.swift
//  Instafilter
//
//  Created by Dayton Bobbitt on 2/1/22.
//

import SwiftUI

class ImageSaver: NSObject {
    func writeToPhotosAlbum(_ image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(saveComplete), nil)
    }
    
    @objc private func saveComplete(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        print("Image saved to photos album!")
    }
}
