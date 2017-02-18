//
//  PhotoHelper.swift
//  Autism-Tracker
//
//  Created by Eric Wong on 2/17/17.
//  Copyright © 2017 Tawpy. All rights reserved.
//

import UIKit

typealias PhotoHelperCallBack = (UIImage?) -> Void

class PhotoTakingHelper: NSObject {
    weak var viewController: UIViewController!
    var callback: PhotoHelperCallBack
    var imagePickerController: UIImagePickerController?
    
    init(viewController: UIViewController, callback: @escaping PhotoHelperCallBack) {
        self.viewController = viewController
        self.callback = callback
        
        
        super.init()
        
        // Because we call showPhotoSourceSelection() directly from the initializer, the dialog will be presented as soon as we create an instance of PhotoTakingHelper.
        if viewController is NewNoteViewController {
            showPhotoSourceSelection(sender: (viewController as! NewNoteViewController).view)
        }
        
    }
    
    func showPhotoSourceSelection(sender : UIView) {
        let alertController = UIAlertController(title: nil, message: "", preferredStyle: .actionSheet)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)

        if (UIImagePickerController.isCameraDeviceAvailable(.rear)) {
            
            let cameraAction = UIAlertAction(title: "Photo from Camera", style: .default) { (action) in
                self.showImagePickerController(sourceType: .camera)
            }

            alertController.addAction(cameraAction)
        }

        let photoLibraryAction = UIAlertAction(title: "Photo from Library", style: .default) { (action) in
            self.showImagePickerController(sourceType: .photoLibrary)
        }
        alertController.addAction(photoLibraryAction)

        
        if let viewController = viewController as? NewNoteViewController {
            alertController.popoverPresentationController?.sourceView = viewController.photoImage
            alertController.popoverPresentationController?.sourceRect   = viewController.photoImage.bounds
        }

        if let popoverController = alertController.popoverPresentationController {
            popoverController.sourceView = sender
            popoverController.sourceRect = sender.bounds
        }
        
        viewController.present(alertController, animated: true, completion: nil)
    }
    
    func showImagePickerController(sourceType: UIImagePickerControllerSourceType) {
        // creates a UIImagePickerController
        
        
        imagePickerController = UIImagePickerController()
        
        imagePickerController!.sourceType = sourceType
        
        imagePickerController!.delegate = self
        imagePickerController!.allowsEditing = true
        
        // present the initialized and configured imagePickerController
        self.viewController.present(imagePickerController!, animated: true, completion: nil)
    }
    
}

extension PhotoTakingHelper: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!) {
        viewController.dismiss(animated: false, completion: nil)
        
        callback(image)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            callback(image)
        } else{
            print("Something went wrong")
        }
        
        viewController.dismiss(animated: false, completion: nil)
    }
    
    
    //simply hide the Image Picker Controller
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        viewController.dismiss(animated: true, completion: nil)
    }
    

}
