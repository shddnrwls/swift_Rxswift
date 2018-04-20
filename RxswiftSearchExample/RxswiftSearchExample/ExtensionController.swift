//
//  ExtensionController.swift
//  RxswiftSearchExample
//
//  Created by mac on 2018. 4. 20..
//  Copyright © 2018년 swift. All rights reserved.
//

import Foundation
import UIKit
extension ViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownCities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CityTableViewCell
        cell.cityTitle.text = shownCities[indexPath.row]
        return cell
    }
    
}
