//
//  ImagePicker.swift
//  DayCareRecordApp
//
//  Created by Jianan Li on 5/16/22.
//


import Foundation
import UIKit
import SwiftUI

struct ImagePicker : UIViewControllerRepresentable {
    
    @Binding var selectedImage : UIImage?
    @Binding var isPickerShowing : Bool
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        //imagePicker.sourceType = .camera. in case you want to take a photo
        imagePicker.delegate = context.coordinator
        
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(self)
    }
}

class Coordinator : NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    var parent : ImagePicker
    
    init(_ picker : ImagePicker){
        self.parent = picker
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        // run the code, when use chooses a photo
        print("image selected")
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            DispatchQueue.main.async{
                self.parent.selectedImage = image
            }
        }
        
        parent.isPickerShowing = false
    }
    
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        // run the code, when user presses the cancel button
        print("cancelled")
        
        parent.isPickerShowing = false
    }
    
    
}
