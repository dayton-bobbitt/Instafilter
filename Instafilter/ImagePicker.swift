//
//  ImagePicker.swift
//  Instafilter
//
//  Created by Dayton Bobbitt on 2/1/22.
//

import PhotosUI
import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    let onSelection: (UIImage?) -> Void
    
    class Coordinator: PHPickerViewControllerDelegate {
        let onSelection: (UIImage?) -> Void
        
        init(onSelection: @escaping (UIImage?) -> Void) {
            self.onSelection = onSelection
        }
        
        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)
            
            guard let provider = results.first?.itemProvider else { return }
            
            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    guard let image = image as? UIImage else { return }

                    self.onSelection(image)
                }
            }
        }
    }
    
    func makeUIViewController(context: Context) -> PHPickerViewController {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images, .livePhotos])
        
        let picker = PHPickerViewController(configuration: configuration)
        
        picker.delegate = context.coordinator
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {
        
    }
    
    
    func makeCoordinator() -> Coordinator {
        Coordinator(onSelection: onSelection)
    }
}
