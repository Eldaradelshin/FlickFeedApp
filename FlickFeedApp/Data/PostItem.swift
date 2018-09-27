

import Foundation

class PostItem {
    let title: String
    let imgUrl: String
    
    
    init?(json: [String: Any]) {
        var mediaDict = json["media"] as! [String:Any]
        
        title = json["title"] as? String ?? ""
        imgUrl = mediaDict["m"] as? String ?? ""
    }
    
    
        static func getArray(from jsonDict: Any) -> [PostItem]? {
        
            let jsonDict = jsonDict as! [String:Any]
            guard let jsonDictArray = jsonDict["items"] as? Array<[String:Any]> else { return nil }
            
            var postItems: [PostItem] = []
            
            for jsonDictObject in jsonDictArray {
                if let postItem = PostItem(json: jsonDictObject) {
                    postItems.append(postItem)
                }
            }
            return postItems
    }
}

