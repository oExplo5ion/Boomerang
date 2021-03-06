//
//  MainPickerMethods.swift
//  Boomerang
//
//  Created by Mac on 8/9/18.
//  Copyright © 2018 Aleksey Robul. All rights reserved.
//

import UIKit

extension MainViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func selectVideoFromLibrary() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.mediaTypes = ["public.movie"]
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let videoUrl = info["UIImagePickerControllerReferenceURL"] as? URL {
            if let frames = BoomerangEffect.createBoomerangFrom(videoUrl: videoUrl) {
                // convert frames to video
                FileConverter.convertImagesToMovie(name: ".temp_boomerang",
                                                   images: frames,
                                                   fps: 30) { url in
                                                    if url != nil {
                                                        self.originalUrl = videoUrl
                                                        self.videoPlayer.setVideo(withUrl: url!)
                                                    }
                }
            }
        }
        imagePicker.dismiss(animated: true, completion: nil)
    }
}





















