//
//  RoomDetailsViewController.swift
//  VT_Test
//
//  Created by Asadullah Jamadar on 28/11/2022.
//

import UIKit

class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var imageView: UIImageView!

    var article: Result
    
    let reuseIdentifier = "NewsDetailsTableViewCell"
    
    init(article: Result) {
        self.article = article
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        
        let f: String? = article.title
        let l: String? = article.title
        
        self.name.text = [f,l]
            .compactMap { $0 }
            .joined(separator: " ")
        
        if let imageURL = article.media?.first?.mediaMetadata?.last?.url{
            self.imageView.download(from: URL(string: imageURL)!, placeholder: UIImage.init(named: "person-placeholder"))
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}


extension NewsDetailsViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsDetailsTableViewCell
        
        cell.title.text = article.section
        cell.source.text = article.subsection
        cell.url.text = article.source?.rawValue
        
        return cell
    }
}
