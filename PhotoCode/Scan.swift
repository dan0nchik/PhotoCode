//
//  Scan.swift
//  PhotoCode
//
//  Created by Daniel Khromov on 4/15/20.
//  Copyright © 2020 Daniel Khromov. All rights reserved.
//

import SwiftUI
struct Scan: View {
    @Binding var useCamera: Bool
    @State var showCaptureImageView=false
    @State var image: Image? = nil
    
    var body: some View {
        ZStack {
            VStack {
                //img
                image?.resizable()
                  .frame(width: 250, height: 250)
                    .aspectRatio(contentMode: .fit)
                Button(action: {
                    print(0)
                }, label: {
                    Text("Scan!")
                })
                
            }
            if (showCaptureImageView) {
              CaptureImageView(isShown: $showCaptureImageView, image: $image, camera: $useCamera)
            }

        }.onAppear {
            self.showCaptureImageView.toggle()
            print(self.useCamera)
        }
    }
}

struct Scan_Previews: PreviewProvider {
    static var previews: some View {
        Scan(useCamera: .constant(true))
    }
}

struct CaptureImageView {
    
    /// MARK: - Properties
    @Binding var isShown: Bool
    @Binding var image: Image?
    @Binding var camera: Bool
    
    func makeCoordinator() -> Coordinator {
      return Coordinator(isShown: $isShown, image: $image)
    }
}
extension CaptureImageView: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<CaptureImageView>) -> UIImagePickerController {
        let picker = UIImagePickerController()
        if(camera == true){
            picker.sourceType = .camera}
        else{
            picker.sourceType = .photoLibrary
        }
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController,
                                context: UIViewControllerRepresentableContext<CaptureImageView>) {
        
    }
}

