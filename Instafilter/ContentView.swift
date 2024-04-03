//
//  ContentView.swift
//  Instafilter
//
//  Created by Shomil Singh on 31/03/24.
//

import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

struct ContentView: View {
    
    @State private var image : Image?
    var body: some View {
        VStack {
            image?
                .resizable()
                .scaledToFit()
        }
        .onAppear(perform: loadImage)
    }
    func loadImage(){
//        image = Image(.gengar)
//        load image in UIimage
        let inputImage = UIImage(resource: .gengar)
        let beginImage = CIImage(image: inputImage)
        
        let context = CIContext()
        let currentfiler = CIFilter.sepiaTone()
        currentfiler.inputImage = beginImage
//        currentfiler.intensity = 1
        let amount = 1.0
        let inputKeys = currentfiler.inputKeys
        
        if(inputKeys.contains(kCIInputIntensityKey)){
            currentfiler.setValue(amount, forKey: kCIInputIntensityKey)
        }
        
        if(inputKeys.contains(kCIInputRadiusKey)){
            currentfiler.setValue(amount * 200, forKey: kCIInputRadiusKey)
        }
        
        if(inputKeys.contains(kCIInputScaleKey)){
            currentfiler.setValue(amount * 10, forKey: kCIInputScaleKey)
        }
        
        
        
        
        
//        ci -> cg -> ui -> swiftUI
        guard let outputImage = currentfiler.outputImage else{return}
        
        guard let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else{return}
        
        let uiImage = UIImage(cgImage: cgImage)
        
        image = Image(uiImage: uiImage)
    }
}

#Preview {
    ContentView()
}
