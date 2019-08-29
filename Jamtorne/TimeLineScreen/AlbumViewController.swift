//
//  AlbumViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/28.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import StoreKit

class AlbumViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let apiClient = APIClient()
    let cloudServiceController = SKCloudServiceController()
    
    var albumID: String!
    var album: Resource?
    
    var canMusicCatalogPlayback = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepare()
    }
    
    func prepare() {
        apiClient.album(id: albumID) { [unowned self] album in
            DispatchQueue.main.async {
                self.album = album
                self.tableView.reloadData()
            }
        }
        
        self.cloudServiceController.requestCapabilities { capabilities, error in
            guard capabilities.contains(.musicCatalogPlayback) else { return }
            self.canMusicCatalogPlayback = true
        }
    }

}

extension AlbumViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let album = album else { return 0 }
        if section == 0 {
            return 1
        } else {
            return album.relationships!.tracks!.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AlbumHeaderCell", for: indexPath) as! AlbumHeaderCell
            cell.nameLabel.text = album!.attributes?.name
            cell.artistLabel.text = album!.attributes?.artistName
            cell.yearLabel.text = album!.attributes?.releaseDate
            if let url = album!.attributes?.artwork?.imageURL(width: 220, height: 220) {
                apiClient.image(url: url) { image in
                    cell.thubmnailView.image = image
                }
            }
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let track = album?.relationships!.tracks![indexPath.row]
        cell.textLabel?.text = track?.attributes?.name
        return cell
    }
    
    
}



