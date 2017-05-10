//
//  MineInfoViewController.swift
//  wenovel
//
//  Created by Tbxark on 10/05/2017.
//  Copyright © 2017 Tbxark. All rights reserved.
//

import UIKit

class MineInfoViewController: UIViewController {
    
    enum Section: Int {
        case user = 0
        case data = 1
        case app  = 2
    }
    fileprivate let dataInfo = ["Drafts", "My Story", "Message"]
    fileprivate let appInfo = ["Settings", "About"]
    @IBOutlet weak var settingList: UITableView! {
        didSet {
            settingList.separatorStyle = .none
            settingList.backgroundColor = UIColor.white
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


extension MineInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
       return 1
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        switch section {
        case .user: return SettingUserPreviewTableViewCell.defaultHeight
        default: return 50
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let section = Section(rawValue: section) else { fatalError() }
        switch section {
        case .user: return 1
        case .data: return dataInfo.count
        case .app: return appInfo.count
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let section = Section(rawValue: indexPath.section) else { return  }
        switch (section, indexPath.row) {
        case (.user, _): return
        case (.data, _): return
        case (.app, 0):
            performSegue(withIdentifier: R.segue.mineInfoViewController.settingList, sender: nil)
        case (.app, 1):
            performSegue(withIdentifier: R.segue.mineInfoViewController.about, sender: nil)
        default:
            return
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { fatalError() }
        switch section {
        case .user:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userInfoPreviewTableViewCell)!
            return cell
        case .data:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userInfoTextTableViewCell)!
            cell.textLabel?.text = dataInfo[indexPath.row]
            return cell
        case .app:
            let cell = tableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.userInfoTextTableViewCell)!
            cell.textLabel?.text = appInfo[indexPath.row]
            return cell
        }
    }
}
