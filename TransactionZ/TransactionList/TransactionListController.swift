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
    var model: TransactionListModel?
    var dataTask: Cancellable?
    lazy var networkingService: NetworkingService = NetworkingService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        start()
    }
    
    @IBAction func refresh(sender: UIRefreshControl) {
        start(control: refreshControl)
    }
    
    func start(control: UIRefreshControl? = nil) {
        dataTask?.cancel()
        dataTask = networkingService.get(url: URL(string: "https://www.mocky.io/v2/5b33bdb43200008f0ad1e256")!)  { [weak self] (result: Result<TransactionListModel>) in
            switch result {
            case .success(let value):
                self?.model = value
            default:
                () //whatever we have to do in an error situation which is not clear in the code challenge
            }
            if control?.isRefreshing == true {
                control?.endRefreshing()
            }
            self?.tableView.reloadData()
        }
    }
}

extension TransactionListController { //UITableViewDataSource
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TransactionCell.identifier, for: indexPath)
        guard let dataReceiver = cell as? TransactionDisplayable,
            let model = model?[indexPath.row] else {
                let cell = UITableViewCell(style: .default, reuseIdentifier: nil)
                cell.textLabel?.text = "Error loading data"
                return cell
        }
        dataReceiver.apply(transaction: model)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model?.count ?? 0
    }
}

class TransactionCell: UITableViewCell, TransactionDisplayable {
    static let identifier = "transaction"
    
    @IBOutlet var descriptionLabel: UILabel!
    @IBOutlet var amountLabel: UILabel!
    @IBOutlet var productImageView: UIImageView!
}

protocol TransactionDisplayable {
    var descriptionLabel: UILabel! { get }
    var amountLabel: UILabel! { get }
    var productImageView: UIImageView! { get }
}

extension TransactionDisplayable {
    func apply(transaction: TransactionDetailModel) {
        descriptionLabel?.text = transaction.description
        amountLabel?.text = transaction.amount.description
        ImageLoader.get(url: transaction.product.icon, in: productImageView)
    }
}

extension Amount: CustomStringConvertible {
    var description: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.currencySymbol = CurrencyFinder.locale(for: currency_iso)?.currencySymbol
        numberFormatter.numberStyle = .currency
        return numberFormatter.string(from: value as NSNumber) ?? "-."
    }
}
