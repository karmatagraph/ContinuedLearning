//
//  FileManagerBootcamp.swift
//  ContinuedLearning
//
//  Created by karma on 6/7/22.
//

import SwiftUI


class LocalFileManager{
    
    static let instance = LocalFileManager()
    
    func saveImage(image: UIImage, name: String) {
        guard let data = image.jpegData(compressionQuality: 1.0),
              let path = getPathForImage(name: name)
        else {
            print("Error getting data")
            return
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
        } catch let error {
            print(error.localizedDescription, " <----------Error saving image data")
        }
    }
    
    func getImage(name: String) -> UIImage? {
        guard let path = getPathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path)
        else {
            print("error getting path or file doesn't exist")
            return nil
        }
        return UIImage(contentsOfFile: path.path)
    }
    
    func getPathForImage(name: String) -> URL? {
        guard
            let path = FileManager
                .default
                .urls(for: .cachesDirectory, in: .userDomainMask)
                .first?
                .appendingPathComponent("\(name).jpeg") else {
            print("error geting path")
            return nil
        }
        return path
    }
    
    func deleteImage(name: String) {
        guard let path = getPathForImage(name: name),
              FileManager.default.fileExists(atPath: path.path)
        else {
            print("error getting path or file doesn't exist")
            return
        }
        do {
            try FileManager.default.removeItem(at: path)
            print("deleted successfully")
        } catch let error {
            print(error, "<------ error deleting image")
        }
    }
    
}

class FileManagerViewModel: ObservableObject {
    
    @Published var image: UIImage? = nil
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
        manager.saveImage(image: image, name: imageName)
    }
    
    func deleteImage() {
        manager.deleteImage(name: imageName)
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
