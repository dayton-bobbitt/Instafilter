//
//  ContentView.swift
//  Instafilter
//
//  Created by Dayton Bobbitt on 2/1/22.
//

import CoreImage
import CoreImage.CIFilterBuiltins
import SwiftUI

struct ContentView: View {
    @State private var uiImage: UIImage?
    @State private var isShowingImagePicker = false
    
    private var image: Image? {
        guard let uiImage = uiImage else { return nil }

        return Image(uiImage: uiImage)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                image?
                    .resizable()
                    .scaledToFill()
                
                Button("Select an image") {
                    isShowingImagePicker = true
                }
            }
            .toolbar {
                ToolbarItem(placement: .primaryAction) {
                    Button("Save image", action: saveImage)
                        .disabled(image == nil)
                }
            }
            .sheet(isPresented: $isShowingImagePicker) {
                ImagePicker { uiImage in
                    self.uiImage = uiImage
                }
            }
        }
    }
    
    private func saveImage() {
        guard let uiImage = uiImage else { return }

        let imageSaver = ImageSaver()
        
        imageSaver.writeToPhotosAlbum(uiImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
