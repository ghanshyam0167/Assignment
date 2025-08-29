
import UIKit

struct Note: Codable {
    let title : String
    let text : String
    let timeStamp : Date
}

let newNote = Note(title: "xyz", text: "Hello", timeStamp: Date())

let propertyListEncoder = PropertyListEncoder()
if let encodedNote = try? propertyListEncoder.encode(newNote){
    print(encodedNote)
    
    let propertyListDecoder = PropertyListDecoder()
    if let decodedNote = try? propertyListDecoder.decode(Note.self, from: encodedNote){
        print(decodedNote)
    }
}

let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!


