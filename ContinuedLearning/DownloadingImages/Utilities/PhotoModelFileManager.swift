//
//  PhotoModelFileManager.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import SwiftUI

class PhotoModelFileManager {
    static let instance = PhotoModelFileManager()
    let folderName = "Downloaded_photos"
    private init() {
        createFolderIfNeeded()
    }
    
    private func createFolderIfNeeded() {
        guard let url = getFolderPath() else { return }
        if !FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default
                    .createDirectory(atPath: url.path , withIntermediateDirectories: true)
                print("created folder")
            } catch let error {
                print("error creating folder \(error.localizedDescription)")
            }
        }
    }
    
    private func getFolderPath() -> URL? {
        FileManager.default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getImagePath(key: String) -> URL? {
        guard let folder = getFolderPath() else { return nil }
        return folder.appendingPathComponent(key + ".png")
    }
    
    func add(key: String, value: UIImage) {
        guard let data = value.pngData(),
              let url = getImagePath(key: key) else { return }
        do {
            try data.write(to: url)
        } catch let error {
            print(error.localizedDescription, "error saving")
        }
    }
    
    func get(key: String) -> UIImage? {
        guard
            let url = getImagePath(key: key),
            FileManager.default.fileExists(atPath: url.path) else { return nil
        }
        return UIImage(contentsOfFile: url.path)
        
    }
    
}
