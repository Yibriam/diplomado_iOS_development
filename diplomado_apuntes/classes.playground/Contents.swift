import UIKit

class MediaItem {
    let id: UUID
    var title: String
    
    init(title: String) {
        self.id = UUID()
        self.title = title
    }
    
//    required init() {
//        self.id = UUID()
//        self.title = ""
//    }
    
    func display() -> String {
        "Media Item"
    }
}

let mediaItem = MediaItem(title: "media item")

class Video: MediaItem {
    let duration: TimeInterval
    var isHD: Bool
    
    init(title: String, duration: TimeInterval, hd: Bool = false) {
        self.duration = duration
        self.isHD = hd
        super.init(title: title)
    }
    
    convenience init(HDVideo title: String, duration: TimeInterval) {
        self.init(title: title, duration: duration, hd: true)
    }
    
    required init() {
        self.duration = 0.0
        self.isHD = false
        super.init(title: "")
    }
    
}

let video = Video(title: "my video", duration: 0.2)
let hdVideo = Video(HDVideo: "HDVidew", duration: 0.2)
let emptyVideo = Video()
//video.id


class Image: MediaItem {
    var width: Int
    var heigth: Int
    
    init(title: String, width: Int, heigth: Int) {
        self.width = width
        self.heigth = heigth
        super.init(title: title)
    }
}


let profilePicture = Image(title: "pf pic", width: 10, heigth: 10)
profilePicture.width = 25
profilePicture.width

let image2 = Image(title: "", width: 83, heigth: 37)
//profilePicture = image2 // nope

let profilePictureCopy = profilePicture
profilePictureCopy.heigth = 37287
profilePicture.heigth
profilePictureCopy.heigth

profilePicture === image2





final class PremiumVideo: Video {
    
    var drmToken: String = ""
    var ads: [String] = []
    
    override var isHD: Bool {
        get {
            return true
        }
        set {
            
        }
    }
    
    required init() {
        super.init()
    }
    
    override func display() -> String {
        super.display() + "Video"
    }
    
    deinit {  /*cleanup*/ }
}

let premVideo = PremiumVideo()
premVideo.isHD = false
premVideo.isHD
premVideo.isHD = true
premVideo.isHD



class Author {
    let name : String
    weak var library: Library?
    
    init(name: String, library: Library? = nil) {
        self.name = name
        self.library = library
    }
}

class Library {
    let id = UUID()
    var curator: Author
    
    init(curator: Author) {
        self.curator = curator
    }
}


let author = Author(name: "Grecia")
let library = Library(curator: author)
author.library

class StringClass {
    var value: String
    
    init(_ value: String) {
        self.value = value
    }
    
    func format(using formatter: (Int) -> String) -> StringClass {
        var formattedString = ""
        for (index, _) in value.enumerated() {
            formattedString.append(formatter(index))
        }
        return StringClass(formattedString)
    }
}

class MyUserController {
    var userName: StringClass
    
    init(userName: String) {
        self.userName = StringClass(userName)
    }
    
    
    func emojifyUserName() {
        userName = userName.format(using: { [weak self] number in
            self?.emojiBy(number: number) ?? ""
        })
    }
    
    func emojiBy(number: Int) -> String {
        return switch number {
        case 1: "😊"
        case 2: "😁"
        case 3: "😿"
        case 4: "😉"
        case 5: "🥳"
        case 6: "🥸"
        case 7: "🤓"
        case 8: "😜"
        default: "😏"
        }
    }
    
}

let user = MyUserController(userName: "Grecia")
user.emojifyUserName()
user.userName.value
