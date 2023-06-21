//
//  RestaurantDiffableDataSource.swift
//  FoodPin
//
//  Created by Shaunak Mehta on 3/06/2023.
//

import UIKit

enum Section {
    case all
}

class RestaurantDiffableDataSource: UITableViewDiffableDataSource<Section, Restaurant> {

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

}
