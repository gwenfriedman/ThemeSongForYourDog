////
////  RecordVideoViewController.swift
////  Dog Theme Song
////
////  Created by Gwen Friedman on 10/4/19.
////  Copyright © 2019 Gwen Friedman. All rights reserved.
////
//
//
//import UIKit
//import MobileCoreServices
//
//class RecordVideoViewController: UIViewController {
//
//    @IBAction func record(_ sender: AnyObject) {
//        VideoHelper.startMediaBrowser(delegate: self, sourceType: .camera)
//    }
//
//    @objc func video(_ videoPath: String, didFinishSavingWithError error: Error?, contextInfo info: AnyObject) {
//        let title = (error == nil) ? "Success" : "Error"
//        let message = (error == nil) ? "Video was saved" : "Video failed to save"
//
//        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil))
//        present(alert, animated: true, completion: nil)
//    }
//
//}
//
//// MARK: - UIImagePickerControllerDelegate
//
//extension RecordVideoViewController: UIImagePickerControllerDelegate {
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
//        dismiss(animated: true, completion: nil)
//
//        guard let mediaType = info[UIImagePickerController.InfoKey.mediaType] as? String,
//            mediaType == (kUTTypeMovie as String),
//            let url = info[UIImagePickerController.InfoKey.mediaURL] as? URL,
//            UIVideoAtPathIsCompatibleWithSavedPhotosAlbum(url.path)
//            else { return }
//
//        // Handle a movie capture
//        UISaveVideoAtPathToSavedPhotosAlbum(url.path, self, #selector(video(_:didFinishSavingWithError:contextInfo:)), nil)
//    }
//
//}
//
//// MARK: - UINavigationControllerDelegate
//
//extension RecordVideoViewController: UINavigationControllerDelegate {
//}
