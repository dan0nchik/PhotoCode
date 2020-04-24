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
    @State var result: String? = "No text"
    var body: some View {
        ZStack {
            VStack {
                //img
                image?.resizable()
                    .frame(width: 250, height: 250)
                    .aspectRatio(contentMode: .fit)
                Button(action: {
                    self.result = callOCRSpace(image: self.image)!
                    print(self.result ?? "No text(")
                }, label: {
                    Text("Scan!")
                })
                Text(result!)
                .bold()
                .foregroundColor(.black)
                .lineLimit(nil)
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

func callOCRSpace(image: Image?) -> String!{
    var final = ""
    // Create URL request
    let url = URL(string: "https://api.ocr.space/Parse/Image")
    var request: URLRequest? = nil
    if let url = url {
        request = URLRequest(url: url)
    }
    request?.httpMethod = "POST"
    let boundary = "randomString"
    request?.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
    
    let session = URLSession.shared
    
    // Image file and parameters
    let imageData = UIImage(named: "test")?.jpegData(compressionQuality: 1)
    let parametersDictionary = ["apikey" : "9ae1728a2c88957", "isOverlayRequired" : "True", "language" : "eng"]
    
    // Create multipart form body
    let data = createBody(withBoundary: boundary, parameters: parametersDictionary, imageData: imageData, filename: "test.png")
    
    request?.httpBody = data
    
    // Start data session
    var task: URLSessionDataTask? = nil
    if let request = request {
        task = session.dataTask(with: request, completionHandler: { (data, response, error) in
            var result: [AnyHashable : Any]? = nil
            do {
                if let data = data {
                    result = try JSONSerialization.jsonObject(with: data, options: []) as? [AnyHashable : Any]
                }
            } catch let myError {
                print(myError)
            }
            //print(result!)
            if let res = result!["ParsedResults"] as? [[String:Any]],
                let text = res.first{
                let output = text["ParsedText"].unsafelyUnwrapped
                //print(output)
                final = output as! String
                print(final)
            }
        })
    }
    task?.resume()
    return final
}

func createBody(withBoundary boundary: String?, parameters: [AnyHashable : Any]?, imageData data: Data?, filename: String?) -> Data? {
    var body = Data()
    if data != nil {
        if let data1 = "--\(boundary ?? "")\r\n".data(using: .utf8) {
            body.append(data1)
        }
        if let data1 = "Content-Disposition: form-data; name=\"\("file")\"; filename=\"\(filename ?? "")\"\r\n".data(using: .utf8) {
            body.append(data1)
        }
        if let data1 = "Content-Type: image/jpeg\r\n\r\n".data(using: .utf8) {
            body.append(data1)
        }
        if let data = data {
            body.append(data)
        }
        if let data1 = "\r\n".data(using: .utf8) {
            body.append(data1)
        }
    }
    
    for key in parameters!.keys {
        if let data1 = "--\(boundary ?? "")\r\n".data(using: .utf8) {
            body.append(data1)
        }
        if let data1 = "Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8) {
            body.append(data1)
        }
        if let parameter = parameters?[key], let data1 = "\(parameter)\r\n".data(using: .utf8) {
            body.append(data1)
        }
    }
    
    if let data1 = "--\(boundary ?? "")--\r\n".data(using: .utf8) {
        body.append(data1)
    }
    
    return body
}
