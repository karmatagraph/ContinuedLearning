//
//  FileManagerBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import SwiftUI


class LocalFileManager{
    
    static let instance = LocalFileManager()
    let folderName = "MyApp_Images"
    init() {
        createFolderIfNeeded()
    }
    
    func createFolderIfNeeded() {
        guard
            let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            .path
        else { return }
        if !FileManager.default.fileExists(atPath: path) {
            do {
                try FileManager.default.createDirectory(atPath: path, withIntermediateDirectories: true)
                print("success creating folder")
            } catch let error {
                print("error creating folder \(error.localizedDescription)")
            }
        }
    }
    
    func saveImage(image: UIImage, name: String) -> String {
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getPathForImage(name: name)
        else {
            print("Error getting data")
            return "Error getting data"
        }
        // let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // let directory2 = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        // let path = directory2?.appendingPathComponent("\(name).jpeg")
        // let directory3 = FileManager.default.temporaryDirectory
        //        print(directory2)
        //        print(path)
        //        print(directory)
        //        print(directory2)
        //        print(directory3)
        
        do {
            try data.write(to: path)
            print("Success saving data")
            print(path)
            return "Success saving image"
        } catch let error {
            print(error.localizedDescription, " <----------Error saving image data")
            return "Error saving image"
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path)
        else {
            print("error getting path or file doesn't exist")
            return nil
        }
        print(path)
        return UIImage(contentsOfFile: path.path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent(folderName)
                .appendingPathComponent("\(name).jpeg") else {
            print("error geting path")
            return nil
        }
        return path
    }
    
    func deleteImage(name: String) -> String {
        guard let path = getPathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path)
        else {
            print("error getting path or file doesn't exist")
            return "Error getting path"
        }
        do {
            try FileManager.default.removeItem(at: path)
            print("deleted successfully")
            return "Deletion successful"
        } catch let error {
            print(error, "<------ error deleting image")
            return "Error deleting image"
        }
    }
    
    func deleteFolder() {
        guard
            let path = FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
            
        else { return }
        do {
            try FileManager.default.removeItem(at: path)
            print("Succesful deleting folder")
        } catch let error {
            print(error.localizedDescription, "error deleting folder")
        }
    }
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
    @Published var infoMessage: String = ""
    let imageName: String = "index"
    let manager = LocalFileManager.instance
    
    init() {
        getImageFromAssets()
        //        getImageFromFileManager()
    }
    
    func getImageFromFileManager() {
        image = manager.getImage(name: imageName)
    }
    
    func getImageFromAssets() {
        image = UIImage(named: "index")
    }
    
    func saveImage() {
        guard let image = image else {
            return
        }
        infoMessage = manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        infoMessage = manager.deleteImage(name: imageName)
        manager.deleteFolder()
    }
    
}

struct FileManagerBootcamp: View {
    
    @StateObject var vm = FileManagerViewModel()
    
    var body: some View {
        NavigationView{
            VStack {
                if let image = vm.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 200, height: 200)
                        .clipped()
                        .cornerRadius(10)
                }
                HStack {
                    Button {
                        vm.saveImage()
                    } label: {
                        Text("Save to fm")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.blue)
                            .cornerRadius(10)
                        
                    }
                    Button {
                        vm.deleteImage()
                    } label: {
                        Text("Delete from fm")
                            .font(.headline)
                            .foregroundColor(.white)
                            .padding()
                            .background(.red)
                            .cornerRadius(10)
                    }
                }
                Text(vm.infoMessage)
                    .font(.largeTitle)
                    .fontWeight(.semibold)
                    .foregroundColor(.purple)
                Spacer()
            }
            .navigationTitle("File Manager")
        }
    }
}

struct FileManagerBootcamp_Previews: PreviewProvider {
    static var previews: some View {
        FileManagerBootcamp()
    }
}
