//
//  SingleNoteVIewController.swift
//  NotesWithLocation
//
//  Created by Arseny Neustroev on 14/11/2019.
//  Copyright © 2019 Arseny Neustroev. All rights reserved.
//

import UIKit

class SingleNoteVIewController: UITableViewController {

    var currentNote : Note?
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        noteNameField.text = currentNote?.name
        noteTextDescriptionView.text = currentNote?.textDescription
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if noteNameField?.text == "" || noteTextDescriptionView?.text == "" {
            CoreDataManager.sharedInstance.managedObjectContext.delete(currentNote!)
            CoreDataManager.sharedInstance.saveContext()
            return
        }
        
        if currentNote?.name != noteNameField.text || currentNote?.description != noteTextDescriptionView.text{
            currentNote?.dateModified = Date()
        }
        
        currentNote?.name = noteNameField.text
        currentNote?.textDescription = noteTextDescriptionView.text
        
        CoreDataManager.sharedInstance.saveContext()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 && indexPath.section == 0{
            let alertController = UIAlertController(title: "Image for note", message: "", preferredStyle: UIAlertController.Style.actionSheet)
            
            let cameraAction = UIAlertAction(title: "Make a photo", style: .default) { (UIAlertAction) in
                self.imagePicker.sourceType = .camera
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(cameraAction)
            
            let photoGalleryAction = UIAlertAction(title: "Select from gallery", style: .default) { (UIAlertAction) in
                self.imagePicker.sourceType = .savedPhotosAlbum
                self.imagePicker.delegate = self
                self.present(self.imagePicker, animated: true, completion: nil)
            }
            alertController.addAction(photoGalleryAction)
            if (self.noteImageView.image != nil){
                let deleteAction = UIAlertAction(title: "Delete photo", style: .destructive) { (UIAlertAction) in
                    self.noteImageView.image = nil
                }
            alertController.addAction(deleteAction)
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBOutlet weak var noteImageView: UIImageView!
    @IBOutlet weak var noteTextDescriptionView: UITextView!
    @IBOutlet weak var noteNameField: UITextField!
}

extension SingleNoteVIewController : UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        noteImageView.image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        picker.dismiss(animated: true, completion: nil)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true, completion: nil)
    }
    
}
