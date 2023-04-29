//
//  NewsListTableViewController.swift
//  NYNewsArticles
//
//  Created by Asadullah Jamadar on 28/04/2023.
//

import UIKit
import SwiftOverlays
//import SDWebImage

class NewsListTableViewController: UITableViewController {
        
    var viewModel = NewsListViewModel(service: WebServiceFactory().createNewsListAPIWorker())
    let reuseIdentifier = "NewsListTableViewCell"
    var dataIsAlreadyLoaded = false

    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = NSLocalizedString("articles_title", comment: "title") //"NY Times Most Popular"
        viewModel.delegate = self
        tableView.register(UINib(nibName: reuseIdentifier, bundle: nil), forCellReuseIdentifier: reuseIdentifier)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    override func viewDidAppear(_ animated: Bool) {
        if(!dataIsAlreadyLoaded){
            fetchNewsArticles()
        }
    }
    
    @objc func fetchNewsArticles(){
        let text = "Please wait..."
        if let superview = self.view.superview {
          SwiftOverlays.showCenteredWaitOverlayWithText(superview, text: "Please wait...")
          //SwiftOverlays.removeAllOverlaysFromView(superview)
        }

        viewModel.fetchNewsArticles()
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.newsResultsArray?.results?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! NewsListTableViewCell
        if let article = viewModel.newsResultsArray?.results?[indexPath.row]{
            cell.titleLabel.text = article.title
            cell.subTitleLabel.text = article.byline
            cell.dateLabel.text = article.publishedDate
            if let thumbURL = article.media?.first?.mediaMetadata?.first?.url{
                cell.thumbnailImageView.download(from: URL(string: thumbURL)!, placeholder: UIImage.init(named: "person-placeholder"))
            }
//            if let thumbURL = article.media?.first?.mediaMetadata?.first?.url{
//                cell.thumbnailImageView.sd_setImage(with: URL(string: thumbURL), placeholderImage: UIImage(systemName: "pencil.circle"))
//            }

        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
     }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
}

extension NewsListTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if let article = viewModel.newsResultsArray?.results?[indexPath.row] {
            
            let detailsViewController = NewsDetailsViewController(article: article)
            navigationItem.backButtonTitle = ""
            navigationController?.pushViewController(detailsViewController, animated: true)
        }
        
    }
}

extension NewsListTableViewController: NewsListUpdateProtocol {
    func fetchNewsFinishedWithSuccess() {
        DispatchQueue.main.async { [unowned self]in
            
            dataIsAlreadyLoaded = true
            
            if let superview = self.view.superview {
              //SwiftOverlays.showCenteredWaitOverlayWithText(superview, text: "Please wait...")
              SwiftOverlays.removeAllOverlaysFromView(superview)
            }
            
            self.tableView.reloadData()
        }
    }
    
    func fetchNewsFailedWithError() {
        
        dataIsAlreadyLoaded = false
        
        switch viewModel.newsError {
        case .invalidURL :
            SwiftOverlays.showTextOverlay(self.tableView, text: "Invalid URL")
        case .missingData :
            SwiftOverlays.showTextOverlay(self.tableView, text: "Missing Data")
        default :
            SwiftOverlays.showTextOverlay(self.tableView, text: "Fetching Failed")

        }
    }
}
