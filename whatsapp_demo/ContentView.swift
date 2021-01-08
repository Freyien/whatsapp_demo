//
//  ContentView.swift
//  whatsapp_demo
//
//  Created by indra on 07/01/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: sharePicture) {
            /*@START_MENU_TOKEN@*//*@PLACEHOLDER=Content@*/Text("Button")/*@END_MENU_TOKEN@*/
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

var documentInteractionController:UIDocumentInteractionController!
func sharePicture() {
    let urlWhats = "whatsapp://app"
    if let urlString = urlWhats.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed) {
        if let whatsappURL = NSURL(string: urlString) {

            if UIApplication.shared.canOpenURL(whatsappURL as URL) {

                let imgURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
                let fileName = "yourImageName.jpg"
                let fileURL = imgURL.appendingPathComponent(fileName)
                if let image = UIImage(contentsOfFile: fileURL.path) {
                    if let imageData = image.jpegData(compressionQuality: 0.75) {
                        let tempFile = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/yourImageName.jpg")
                        do {
                            try imageData.write(to: tempFile!, options: .atomicWrite)
                        } catch {
                            print(error)
                        }
                    }
                }
            } else {
                // Cannot open whatsapp
            }
        }
    }
}
