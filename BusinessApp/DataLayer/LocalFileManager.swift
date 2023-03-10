//
//  FileManager.swift
//  BusinessApp
//
//  Created by alejandro on 10/03/23.
//

import Foundation
import UIKit
protocol LocalFileManagerProtocol {
    func saveImageInLocalFile(image: UIImage, imageId: String)
    func getImageFromLocalFile(imageId: String) -> UIImage?
}

class LocalFileManager {
    let fileManager: FileManager
    let directoryPath: URL?
    let suffix = "_product.jpeg"
    init(fileManager: FileManager = .default, directoryName: String = "ProductImages" ) {
        self.fileManager = fileManager
        let directoryDocument = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first
        self.directoryPath = directoryDocument?.appendingPathComponent(directoryName)
    }
    
    func createFolder() {
        guard let directoryPath = directoryPath else {
            return
        }
        print("image folder: \(directoryPath)")
        guard !fileManager.fileExists(atPath: directoryPath.path) else {
            return
        }
        do {
            try fileManager.createDirectory(
                at: directoryPath,
                withIntermediateDirectories: true,
                attributes: nil)
            print("se creo folder de imagenes: \(directoryPath)")
        } catch {
            print("Error creating directory. \(error)")
        }
    }
    private func saveImage(image: UIImage, imageNameId: String?) {
        guard let data = image.jpegData(compressionQuality: 0), let imageName = imageNameId else {
            return
        }
        guard let imageURL = directoryPath?.appendingPathComponent(imageName) else {
            return
        }
        do {
            try data.write(to: imageURL)
        } catch {
            print("error de guardado de imagen: \(imageName). \n \(error)")
        }
    }
    private func getImage(imageNameId: String) -> UIImage? {
        guard let imageURL = directoryPath?.appendingPathComponent(imageNameId) else {
            return nil
        }
        guard let data = try? Data(contentsOf: imageURL) else {
            return nil
        }
        return UIImage(data: data)
    }
}

extension LocalFileManager: LocalFileManagerProtocol {
    func saveImageInLocalFile(image: UIImage, imageId: String) {
        saveImage(image: image, imageNameId: imageId + suffix)
    }
    // photo.fill
    func getImageFromLocalFile(imageId: String) -> UIImage? {
        getImage(imageNameId: imageId + suffix)
    }
}
