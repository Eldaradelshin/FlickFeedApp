

import Foundation



enum requestMethod : String {
    case getPublicFeed = "/photos_public.gne"
    case getFriendsFeed = "/photos_friends.gne"
    case getGroupPool = "/groups_pool.gne"
}


class urlRequestService {
    
     let base="https://api.flickr.com/services/feeds"
     let parameters = "/?format=json&nojsoncallback=1"
    
    
    func getPublicFeed(completion: @escaping (([PostItem]) -> Void)) {
        
        guard let url = URL(string: base + requestMethod.getPublicFeed.rawValue + parameters) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
            }
            
            if let data = data {
                do {
                    let jsonDict = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers)
                    guard let posts = PostItem.getArray(from: jsonDict) else { return (print("Error in function"))}
                    
                    //print(posts[0].title)
                    //print(posts[0].imgUrl)
                    completion(posts)
            
                } catch let jsonErr {
                    print("Error in JSON parsing", jsonErr)
                }
            
            }
        }
        task.resume()
    }
    
    

}
