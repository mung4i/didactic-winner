//
//  HomeViewController.swift
//  didactic-winner
//
//  Created by Martin Mungai on 30/06/2021.
//

import UIKit

import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    private let cellID = "UITableViewCell"
    private let disposeBag = DisposeBag()
    private var viewModel: BaseViewModel = .init()
    
    // MARK: - IB Outlets
    @IBOutlet weak var tableView: UITableView!

    // MARK: - Overidden Instance Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        bind()
    }
    
    // MARK: - Private Instance Methods
    private func bindTableView(source: Observable<[Item]>) {
        source.bind(
            to: self.tableView.rx.items(
                cellIdentifier: cellID,
                cellType: UITableViewCell.self
            )
        ) { (row, item, cell) in
            
            guard let data = item.data.first else {
                fatalError()
            }
            
            cell.imageView?.image = UIImage()
            cell.textLabel?.text = data.title
            cell.detailTextLabel?.text = data.description508
        }.disposed(by: disposeBag)
    }
    
    private func configureTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.separatorStyle = .none
    }
    
    // MARK: - Instance Methods
    func bind() {
        let output = self.viewModel.bind()
        
        bindTableView(source: output.collection)
        disposeBag.insert(output.title.drive(self.rx.title))
    }
}
