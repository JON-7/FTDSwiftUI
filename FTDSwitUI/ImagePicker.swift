//
//  ImagePicker.swift
//  FTDSwitUI
//
//  Created by Jon E on 10/27/21.
//

import SwiftUI

struct ImagePicker: UIViewControllerRepresentable {
    
    @ObservedObject var viewModel: HomeViewModel
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {
        
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(imagePicker: self)
    }
    
    final class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        
        let imagePicker: ImagePicker
        
        init(imagePicker: ImagePicker) {
            self.imagePicker = imagePicker
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.editedImage] as? UIImage {
                imagePicker.viewModel.tweetImage = image
                imagePicker.viewModel.currentSheet = .scanImage
                imagePicker.viewModel.isSheetSelected = true
            }
        }
    }
}
