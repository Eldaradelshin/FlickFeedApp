
import UIKit

class FeedTableVC: UITableViewController {
    
    let urlService = urlRequestService()
    var downloadedPosts = [PostItem]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        urlService.getPublicFeed() { [weak self] posts in
            
            
            for post in posts {
                
                let randomNumber = arc4random_uniform(5)
                
                if (self?.downloadedPosts.count)! <= randomNumber {
                    self?.downloadedPosts.append(post)
                    print("---------")
                    print(post.title)
                } else { break }
            }
        self?.tableView.reloadData()
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return downloadedPosts.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell", for: indexPath) as! FeedCell

        cell.titleLabel.text = downloadedPosts[indexPath.row].title

        let imgUrl: URL = URL(string: downloadedPosts[indexPath.row].imgUrl)!
        
        let queue = DispatchQueue.global(qos: .utility)
        queue.async{
            if let data = try? Data(contentsOf: imgUrl){
                DispatchQueue.main.async {
                    cell.imageCellView.image = UIImage(data: data)
                }
            }
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 250
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        var shownIndexes: [IndexPath] = []
        if (shownIndexes.contains(indexPath) == false) {
            shownIndexes.append(indexPath)
            
           
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOffset = CGSize(width: 10, height: 10)
            cell.alpha = 0
            
            UIView.beginAnimations("rotation", context: nil)
            UIView.setAnimationDuration(1.0)
            cell.alpha = 1
            cell.layer.shadowOffset = CGSize(width: 0, height: 0)
            UIView.commitAnimations()
        }
    }
    
    
    
    
    
    
}
