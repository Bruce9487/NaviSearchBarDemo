//
//  ViewController.swift
//  NaviSearchBarDemo
//
//  Created by Bruce Chen on 2018/4/10.
//  Copyright © 2018年 bruce. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var songsArray: [String] = ["就是我","會讀書","翅膀","星球","凍結","壓力","女兒家","星空下的吻","讓我心動的人","會有那麼一天","不懂","一開始（In the Beginning)","第二天堂","子彈列車","起床了（Morning Call)","豆漿油條","江南","害怕","天使心","森林浴（In the Woods)","精靈","相信無限","美人魚","距離"]
    
    var searchSongs: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        naviSetting()
        tableViewSetting()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func tableViewSetting() {
        
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.dataSource = self
    }

    func naviSetting() {
        
        navigationController?.navigationBar.prefersLargeTitles = true //Title顯示大字
        
        let searchController = UISearchController(searchResultsController: nil) //建立SearchController物件
        searchController.searchResultsUpdater = self //負責更新搜尋內容的物件
        searchController.dimsBackgroundDuringPresentation = false //搜尋開始畫面不會變暗
        
        navigationItem.searchController = searchController //把searchController設到Navigation上
        navigationItem.hidesSearchBarWhenScrolling = false //滾動不隱藏searchController
        
        definesPresentationContext = true //有Navigation把預設值改為true
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if navigationItem.searchController?.isActive == true {
           
            return searchSongs.count //開始搜尋時顯示搜尋後的資料
        }else{
            
            return songsArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.separatorInset = .zero

        if navigationItem.searchController?.isActive == true {
            
            cell.textLabel?.text = searchSongs[indexPath.row] //開始搜尋時顯示搜尋後的資料
        }else{
            
            cell.textLabel?.text = songsArray[indexPath.row]
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 65 //每個cell高度設為65
    }
    
}

extension ViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
        let searchText = searchController.searchBar.text! //設定search文字
        
        self.searchSongs = self.songsArray.filter { (name) -> Bool in //從歌單中找出符合的歌
            return name.contains(searchText)
        }
        
        self.tableView.reloadData() //更新資料顯示在螢幕上
    }
    
}
