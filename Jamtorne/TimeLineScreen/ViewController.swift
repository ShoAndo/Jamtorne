//
//  ViewController.swift
//  Jamtorne
//
//  Created by 安藤奨 on 2019/08/21.
//  Copyright © 2019 安藤奨. All rights reserved.
//

import UIKit
import StoreKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var post = Post.allPosts
    let cloudServiceController = SKCloudServiceController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "PostTableTableViewCell", bundle: nil), forCellReuseIdentifier: "PostCell")
       
        navigationController?.navigationBar.barTintColor = .white
        navigationController?.navigationBar.tintColor = .white
        title = "Jamtorne"
        
       
        // [1] ミュージックライブラリへのアクセス許可を要求する
        SKCloudServiceController.requestAuthorization { (status) in
            if status != .authorized { return }
            
            // [2] 利用可能な機能を確認する
            // 以下を満たす場合、SKCloudServiceSetupViewController を使用できる
            //     .musicCatalogSubscriptionEligible が含まれている
            //     .musicCatalogPlayback が含まれていない
            self.cloudServiceController.requestCapabilities { (capability, error) in
                if capability.contains(.musicCatalogSubscriptionEligible) &&
                    !capability.contains(.musicCatalogPlayback) {
                    print("you can use SKCloudServiceSetupViewController")
                }
            }
        }
        
        let controller = SKCloudServiceSetupViewController()
        
        // ビューをロードする
        // options に action キーと値 subscribe を指定
        controller.load(options: [.action : SKCloudServiceSetupAction.subscribe],
                        completionHandler: { (result, error) in
                            // ...
        })
        
        present(controller,
                animated: true,
                completion: nil)
    }
    
        
        
    }




extension ViewController:UITableViewDataSource,UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return post.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell", for: indexPath) as! PostTableTableViewCell
        cell.post = post[indexPath.row]
        
        
        return cell
    }
    

    
    
    
}

