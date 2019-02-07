//
//  TransactionListController.swift
//  TransactionZ
//
//  Created by André Vellori on 07/02/2019.
//  Copyright © 2019 André Vellori. All rights reserved.
//

import Foundation
import UIKit

class TransactionListController: UITableViewController {
    var model = TransactionListModel.empty
}

extension TransactionListController { //UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath)
        guard let dataReceiver = cell as? TransactionDisplayable else {
            let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
            cell.textLabel?.text = "Error loading data"
            return cell
        }
        dataReceiver.apply(transaction: model[indexPath.row])
        return cell
    }
}

class TransactionCell: UITableViewCell, TransactionDisplayable {
    static let identifier = "transaction"
    
    @IBOutlet var descriptionLabel: UILabel?
    @IBOutlet var amountLabel: UILabel?
    @IBOutlet var productImageView: UIImageView?
}

protocol TransactionDisplayable {
    var descriptionLabel: UILabel? { get }
    var amountLabel: UILabel? { get }
    var productImageView: UIImageView? { get }
}

extension TransactionDisplayable {
    func apply(transaction: TransactionDetailModel) {
        descriptionLabel?.text = transaction.description
        amountLabel?.text = transaction.amount.description
    }
}

extension Amount: CustomStringConvertible {
    var description: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.locale = CurrencyFinder.locale(for: currency_iso)
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: value as NSNumber) ?? "-."
    }
    
    
}
